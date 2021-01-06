import UIKit
import PinLayout

final class LookViewController: UIViewController {
	var output: LookViewOutput?

    private weak var backgroundView: UIView!

    private weak var lookName: UILabel!

    private weak var backToWardrobe: UIButton!

    private weak var lookParamsButton: UIButton!

    private weak var lookTableView: UITableView!

    private weak var addItemsButton: UIButton!

    private weak var dropMenuView: LookSettingsMenuView!

    private var lookIsEditing: Bool = false

    private var menuIsDropped: Bool?

    private var tapOnMainViewGestureRecognizer: UITapGestureRecognizer!

    private var tapOnHeaderViewGestureRecognizer: UITapGestureRecognizer!

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
        layoutLookParamsButton()
        layoutLookTableView()
        layoutDropMenuView()
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupSubviews() {
        setupBackgroundView()
        setupLookName()
        setupBackToWardrobe()
        setupLookParamsButton()
        setupLookTableView()
        setupDropMenuView()
        setupGestureRecognizers()
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

    private func setupLookParamsButton() {
        let button = UIButton()

        lookParamsButton = button
        backgroundView.addSubview(lookParamsButton)

        lookParamsButton.setImage(UIImage(named: "more",
                                        in: Bundle.main,
                                        with: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        lookParamsButton.tintColor = GlobalColors.backgroundColor
        lookParamsButton.contentVerticalAlignment = .fill
        lookParamsButton.contentHorizontalAlignment = .fill
        lookParamsButton.addTarget(self, action: #selector(didTapLookParamsButton), for: .touchUpInside)
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
        lookTableView.backgroundColor = .white

        let refreshControl = UIRefreshControl()

        refreshControl.addTarget(self, action: #selector(didRequestRefresh), for: .valueChanged)
        lookTableView.refreshControl = refreshControl
    }

    private func setupDropMenuView() {
        let menu = LookSettingsMenuView()

        dropMenuView = menu
        view.addSubview(dropMenuView)

        dropMenuView.output = output
        dropMenuView.dropShadow()
        dropMenuView.isUserInteractionEnabled = true
    }

    private func setupGestureRecognizers() {
        tapOnMainViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLookParamsButton))
        self.lookTableView.isUserInteractionEnabled = true
        tapOnMainViewGestureRecognizer.isEnabled = false
        tapOnMainViewGestureRecognizer.numberOfTouchesRequired = 1
        lookTableView.addGestureRecognizer(tapOnMainViewGestureRecognizer)

        tapOnHeaderViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLookParamsButton))
        tapOnHeaderViewGestureRecognizer.isEnabled = false
        tapOnHeaderViewGestureRecognizer.numberOfTouchesRequired = 1
        backgroundView.addGestureRecognizer(tapOnHeaderViewGestureRecognizer)
    }

    private func enableGesture() {
        tapOnMainViewGestureRecognizer.isEnabled = true
        tapOnHeaderViewGestureRecognizer.isEnabled = true
    }

    private func disableGesture() {
        tapOnMainViewGestureRecognizer.isEnabled = false
        tapOnHeaderViewGestureRecognizer.isEnabled = false
    }

    private func layoutBackgroundView() {
        backgroundView.pin
            .top(.zero)
            .width(100%)
            .height(16%)
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

    private func layoutLookParamsButton() {
        lookParamsButton.pin
            .height(25)
            .width(25)

        lookParamsButton.pin
            .top(lookName.frame.midY - lookParamsButton.bounds.height / 2)
            .right(5%)
    }

    private func layoutLookTableView() {
        lookTableView.pin
            .below(of: backgroundView)
            .hCenter()
            .width(100%)
            .bottom(tabBarController?.tabBar.frame.height ?? 0)
    }

    private func layoutDropMenuView() {
        guard let isDropping = menuIsDropped else {
            return
        }

        if isDropping {
            showDropDownMenu()
        } else {
            hideDropDownMenu()
        }
    }

    private func showDropDownMenu() {
        dropMenuView.pin
            .below(of: lookParamsButton)
            .marginTop(20)
            .right(10)
            .height(0)
            .width(0)
        UIView.animate(withDuration: 0.3) {
            self.dropMenuView.pin
                .below(of: self.lookParamsButton)
                .marginTop(20)
                .right(10)
                .height(13%)
                .width(43%)
            self.view.layoutIfNeeded()
        }
    }

    private func hideDropDownMenu() {
        dropMenuView.pin
            .below(of: lookParamsButton)
            .marginTop(20)
            .right(10)
            .height(13%)
            .width(43%)
        UIView.animate(withDuration: 0.3) {
            self.dropMenuView.pin
                .below(of: self.lookParamsButton)
                .marginTop(20)
                .right(10)
                .height(0)
                .width(0)
            self.view.layoutIfNeeded()
        }
    }

    @objc
    private func didTapBackToWardrobeButton() {
        output?.didTapBackToWardrobeButton()
    }

    @objc
    private func didTapLookParamsButton() {
        output?.didTapLookParamsButton()
    }

    @objc
    private func didRequestRefresh() {
        output?.didRequestRefresh()
    }
}

extension LookViewController: LookViewInput {
    func showEditLayout() {
        lookParamsButton.setImage(UIImage(systemName: "checkmark",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
    }

    func hideEditLayout() {
        lookParamsButton.setImage(UIImage(named: "more",
                                        in: Bundle.main,
                                        with: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
    }

    func setLookIsEditing(isEditing: Bool) {
        lookIsEditing = isEditing
        lookTableView.reloadData()
    }

    func loadData() {
        lookTableView.refreshControl?.endRefreshing()
        lookTableView.reloadData()
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)

        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }

    func setLookTitle(with text: String) {
        lookName.text = "Набор\n\"\(text)\""
    }

    func showDropMenu() {
        enableGesture()
        menuIsDropped = true
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    func hideDropMenu() {
        disableGesture()
        menuIsDropped = false
        view.setNeedsLayout()
        view.layoutIfNeeded()
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

        let cellPresenter = LookTableViewCellPresenter(index: indexPath.row)

        cellPresenter.output = output
        cellPresenter.cell = cell
        cell.output = cellPresenter
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
