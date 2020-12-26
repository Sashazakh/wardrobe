import UIKit
import PinLayout

final class LookViewController: UIViewController {
	var output: LookViewOutput?

    private weak var backgroundView: UIView!

    private weak var lookName: UILabel!

    private weak var backToWardrobe: UIButton!

    private weak var editLookButton: UIButton!

    private weak var lookTableView: UITableView!

    private weak var addItemsButton: UIButton!

    private var lookIsEditing: Bool = false

	override func viewDidLoad() {
		super.viewDidLoad()

        setupView()
        setupSubviews()

        output?.didLoadView()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutBackgroundView()
        layoutLookName()
        layoutBackToWardrobe()
        layoutEditLookButton()
        layoutLookTableView()
        layoutAddItemsButton()
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupSubviews() {
        setupBackgroundView()
        setupLookName()
        setupBackToWardrobe()
        setupEditLookButton()
        setupLookTableView()
        setupAddItemsButton()
    }

    private func setupBackgroundView() {
        let background = UIView()

        backgroundView = background
        view.addSubview(backgroundView)

        backgroundView.backgroundColor = GlobalColors.mainBlueScreen
    }

    private func setupLookName() {
        let label = UILabel()

        lookName = label
        backgroundView.addSubview(lookName)

        lookName.font = UIFont(name: "DMSans-Bold", size: 25)
        lookName.textColor = .white
        lookName.textAlignment = .center
        lookName.text = "Набор\n\"Гулянка\""
        lookName.adjustsFontSizeToFitWidth = true
        lookName.minimumScaleFactor = 0.1
        lookName.numberOfLines = 0

    }

    private func setupBackToWardrobe() {
        let button = UIButton()

        backToWardrobe = button
        backgroundView.addSubview(backToWardrobe)

        backToWardrobe.setImage(UIImage(systemName: "chevron.backward",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        backToWardrobe.tintColor = GlobalColors.backgroundColor
        backToWardrobe.contentVerticalAlignment = .fill
        backToWardrobe.contentHorizontalAlignment = .fill
        backToWardrobe.addTarget(self, action: #selector(didTapBackToWardrobeButton), for: .touchUpInside)
    }

    private func setupEditLookButton() {
        let button = UIButton()

        editLookButton = button
        backgroundView.addSubview(editLookButton)

        editLookButton.setImage(UIImage(systemName: "square.and.pencil",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        editLookButton.tintColor = GlobalColors.backgroundColor
        editLookButton.contentVerticalAlignment = .fill
        editLookButton.contentHorizontalAlignment = .fill
        editLookButton.addTarget(self, action: #selector(didTapEditLookButton), for: .touchUpInside)
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

    private func setupAddItemsButton() {
        let button = UIButton()

        addItemsButton = button
        view.addSubview(addItemsButton)

        addItemsButton.isHidden = true
        addItemsButton.backgroundColor = GlobalColors.mainBlueScreen
        addItemsButton.layer.cornerRadius = 10
        addItemsButton.dropShadow()

        addItemsButton.titleLabel?.font = UIFont(name: "DMSans-Regular", size: 15)
        addItemsButton.setTitleColor(.white, for: .normal)
        addItemsButton.setTitle("Добавить предметы", for: .normal)

        addItemsButton.addTarget(self, action: #selector(didTapAddItemsButton), for: .touchUpInside)
    }

    private func layoutBackgroundView() {
        backgroundView.pin
            .top(.zero)
            .width(100%)
            .height(Constants.screenHeight * 0.07 + 30 + 5 + 30 + 15)
    }

    private func layoutLookName() {
        lookName.pin
            .top(40%)
            .hCenter()
            .width(50%)
            .height(50)
    }

    private func layoutBackToWardrobe() {
        backToWardrobe.pin
            .height(25)
            .width(20)

        backToWardrobe.pin
            .top(lookName.frame.midY - backToWardrobe.bounds.height / 2)
            .left(5%)
    }

    private func layoutEditLookButton() {
        editLookButton.pin
            .height(25)
            .width(25)

        editLookButton.pin
            .top(lookName.frame.midY - editLookButton.bounds.height / 2)
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

    private func layoutAddItemsButton() {
        addItemsButton.pin
            .top(lookTableView.frame.maxY + 5)
            .hCenter()
            .width(96%)
            .height(44)
    }

    @objc
    private func didTapBackToWardrobeButton() {
        output?.didTapBackToWardrobeButton()
    }

    @objc
    private func didTapEditLookButton() {
        output?.didTapEditLookButton()
    }

    @objc
    private func didTapAddItemsButton() {
        output?.didTapAddItemsButton()
    }
}

extension LookViewController: LookViewInput {
    func showEditLayout() {
        editLookButton.setImage(UIImage(systemName: "checkmark",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        addItemsButton.isHidden = false
    }

    func hideEditLayout() {
        editLookButton.setImage(UIImage(systemName: "square.and.pencil",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        addItemsButton.isHidden = true
    }

    func setLookIsEditing(isEditing: Bool) {
        lookIsEditing = isEditing
        lookTableView.reloadData()
    }

    func loadData() {
        lookTableView.reloadData()
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)

        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
}

extension LookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GlobalConstants.cellSize.height * 1.3
    }
}

extension LookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.getRowsCount() ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LookTableViewCell", for: indexPath) as? LookTableViewCell else {
            return UITableViewCell()
        }

        cell.setIsEditing(isEditing: lookIsEditing)
        cell.selectionStyle = .none

        guard let model = output?.viewModel(index: indexPath.row) else {
            return cell
        }

        cell.configure(viewModel: model)

        return cell
    }
}

extension LookViewController {
    private struct Constants {
        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        static let screenWidth: CGFloat = UIScreen.main.bounds.width
    }
}
