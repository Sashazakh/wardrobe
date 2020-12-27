import UIKit
import PinLayout

final class AllItemsViewController: UIViewController {
    var output: AllItemsViewOutput?

    private weak var backgroundView: UIView!

    private weak var titleLabel: UILabel!

    private weak var backToLookButton: UIButton!

    private weak var confirmButton: UIButton!

    private weak var allItemsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSubviews()

        output?.didLoadView()
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
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.1
        titleLabel.numberOfLines = 0
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

        allItemsTableView = tableView
        view.addSubview(tableView)

        allItemsTableView.register(AllItemsTableViewCell.self, forCellReuseIdentifier: "AllItemsTableViewCell")

        allItemsTableView.delegate = self
        allItemsTableView.dataSource = self

        allItemsTableView.showsVerticalScrollIndicator = false
        allItemsTableView.showsHorizontalScrollIndicator = false
        allItemsTableView.separatorStyle = .none
        allItemsTableView.contentInset = UIEdgeInsets(top: 10,
                                                  left: 0,
                                                  bottom: 0,
                                                  right: 0)
        allItemsTableView.setContentOffset(CGPoint(x: .zero, y: -10), animated: true)
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
            .width(40%)
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
        allItemsTableView.pin
            .below(of: backgroundView)
            .hCenter()
            .width(100%)
            .bottom(tabBarController?.tabBar.frame.height ?? 0)

        let gradientLayerUp = CAGradientLayer()

        gradientLayerUp.frame = CGRect(x: .zero,
                                     y: allItemsTableView.frame.minY,
                                     width: allItemsTableView.bounds.width,
                                     height: 4)
        gradientLayerUp.colors = [GlobalColors.mainBlueScreen.cgColor,
                                  UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor]
        view.layer.addSublayer(gradientLayerUp)

        let gradientLayerDown = CAGradientLayer()

        gradientLayerDown.frame = CGRect(x: .zero,
                                     y: allItemsTableView.frame.maxY - 4,
                                     width: allItemsTableView.bounds.width,
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

    func loadData() {
        allItemsTableView.reloadData()
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)

        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
}

extension AllItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GlobalConstants.cellSize.height * 1.3
    }
}

extension AllItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.getRowsCount() ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllItemsTableViewCell", for: indexPath) as? AllItemsTableViewCell else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none

        guard let model = output?.viewModel(index: indexPath.row) else {
            return cell
        }

        cell.configure(model: model)

        return cell
    }
}

extension AllItemsViewController {
    private struct Constants {
        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        static let screenWidth: CGFloat = UIScreen.main.bounds.width
    }
}
