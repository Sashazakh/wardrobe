import UIKit
import PinLayout

final class AllItemsViewController: UIViewController {
    var output: AllItemsViewOutput?

    private weak var backgroundView: UIView!

    private weak var titleLabel: UILabel!

    private weak var backToLookButton: UIButton!

    private weak var confirmButton: UIButton!

    private weak var lookTableView: UITableView!

    private var lookIsEditing: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutBackgroundView()
        layoutTitleLabel()
        layoutBackToLookButton()
        layoutConfirmButton()
        layoutLookTableView()
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupSubviews() {
        setupBackgroundView()
        setupTitleLabel()
        setupBackToLookButton()
        setupConfirmButton()
        setupLookTableView()
    }

    private func setupBackgroundView() {
        let background = UIView()

        backgroundView = background
        view.addSubview(backgroundView)

        backgroundView.backgroundColor = GlobalColors.mainBlueScreen
    }

    private func setupTitleLabel() {
        let label = UILabel()

        titleLabel = label
        backgroundView.addSubview(titleLabel)

        titleLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "Мои предметы"
    }

    private func setupBackToLookButton() {
        let button = UIButton()

        backToLookButton = button
        backgroundView.addSubview(backToLookButton)

        backToLookButton.setImage(UIImage(systemName: "chevron.backward",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        backToLookButton.tintColor = GlobalColors.backgroundColor
        backToLookButton.contentVerticalAlignment = .fill
        backToLookButton.contentHorizontalAlignment = .fill
        backToLookButton.addTarget(self, action: #selector(didTapBackToLookButton), for: .touchUpInside)
    }

    private func setupConfirmButton() {
        let button = UIButton()

        confirmButton = button
        backgroundView.addSubview(confirmButton)

        confirmButton.setImage(UIImage(systemName: "square.and.pencil",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        confirmButton.tintColor = GlobalColors.backgroundColor
        confirmButton.contentVerticalAlignment = .fill
        confirmButton.contentHorizontalAlignment = .fill
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }

    private func setupLookTableView() {
        let tableView = UITableView()

        lookTableView = tableView
        view.addSubview(tableView)

        lookTableView.register(LookTableViewCell.self, forCellReuseIdentifier: "LookTableViewCell")

        lookTableView.delegate = self
        lookTableView.dataSource = self

        lookTableView.showsVerticalScrollIndicator = false
        lookTableView.showsHorizontalScrollIndicator = false
        lookTableView.separatorStyle = .none
        lookTableView.contentInset = UIEdgeInsets(top: 10,
                                                  left: 0,
                                                  bottom: 0,
                                                  right: 0)
        lookTableView.setContentOffset(CGPoint(x: .zero, y: -10), animated: true)
    }

    private func layoutBackgroundView() {
        backgroundView.pin
            .top(.zero)
            .width(100%)
            .height(Constants.screenHeight * 0.07 + 30 + 5 + 30 + 15)
    }

    private func layoutTitleLabel() {
        titleLabel.pin
            .top(50%)
            .hCenter()
            .width(50%)
            .height(30)
    }

    private func layoutBackToLookButton() {
        backToLookButton.pin
            .height(25)
            .width(20)

        backToLookButton.pin
            .top(backgroundView.bounds.height * 0.6 - backToLookButton.bounds.height / 2)
            .left(5%)
    }

    private func layoutConfirmButton() {
        confirmButton.pin
            .height(25)
            .width(25)

        confirmButton.pin
            .top(backgroundView.bounds.height * 0.6 - confirmButton.bounds.height / 2)
            .right(5%)
    }

    private func layoutLookTableView() {
        lookTableView.pin
            .below(of: backgroundView)
            .hCenter()
            .width(100%)
            .bottom((tabBarController?.tabBar.frame.height ?? 0) + 55)

        let gradientLayerUp = CAGradientLayer()

        gradientLayerUp.frame = CGRect(x: .zero,
                                     y: lookTableView.frame.minY,
                                     width: lookTableView.bounds.width,
                                     height: 4)
        gradientLayerUp.colors = [GlobalColors.mainBlueScreen.cgColor,
                                  UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor]
        view.layer.addSublayer(gradientLayerUp)

        let gradientLayerDown = CAGradientLayer()

        gradientLayerDown.frame = CGRect(x: .zero,
                                     y: lookTableView.frame.maxY - 4,
                                     width: lookTableView.bounds.width,
                                     height: 4)
        gradientLayerDown.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor,
                                    UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
        view.layer.addSublayer(gradientLayerDown)
    }

    @objc
    private func didTapBackToLookButton() {
        output?.didTapBackToLookButton()
    }

    @objc
    private func didTapConfirmButton() {
        output?.didTapConfirmButton()
    }
}

extension AllItemsViewController: AllItemsViewInput {
    func showEditLayout() {
        confirmButton.setImage(UIImage(systemName: "checkmark",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
    }

    func hideEditLayout() {
        confirmButton.setImage(UIImage(systemName: "square.and.pencil",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
    }

    func setLookIsEditing(isEditing: Bool) {
        lookIsEditing = isEditing
        lookTableView.reloadData()
    }
}

extension AllItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.bounds.height - 10) / 3
    }
}

extension AllItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LookTableViewCell", for: indexPath) as? LookTableViewCell else {
            return UITableViewCell()
        }

        cell.setIsEditing(isEditing: lookIsEditing)
        cell.selectionStyle = .none

        return cell
    }
}

extension AllItemsViewController {
    private struct Constants {
        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        static let screenWidth: CGFloat = UIScreen.main.bounds.width
    }
}
