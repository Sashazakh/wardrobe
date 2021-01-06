import UIKit
import PinLayout

final class AllClothesViewController: UIViewController {

    private weak var headerView: UIView!
    private weak var moreButton: UIButton!
    private weak var pageTitle: UILabel!
    private weak var categoriesTableView: UITableView!
    private weak var dropMenuView: AllClothesDropDownView!
    private let screenBounds = UIScreen.main.bounds
    private var tapOnMainViewGestureRecognizer: UITapGestureRecognizer!
    private var tapOnHeaderViewGestureRecognizer: UITapGestureRecognizer!
    private var menuIsDropped: Bool?
    var editMode: Bool = false

	var output: AllClothesViewOutput?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.setNeedsLayout()
        view.layoutIfNeeded()
        output?.didLoadView()
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        setupUI()
        output?.didLoadView()
	}

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        output?.forceHideDropView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }

    @objc private func didTapMoreButton() {
        output?.didTapMoreMenuButton()
    }

    @objc private func didTapEditButton() {
        output?.didTapEditButton()
    }

    @objc private func didRefreshRequested() {
        output?.didRefreshRequested()
    }
}

extension AllClothesViewController {
    private func setupUI() {
        setupBackground()
        setupHeaderView()
        setupPageTitle()
        setupEditButton()
        setupCategoriesTableView()
        setupDropMenuView()
        setupGestureRecognizers()
    }

    private func layoutUI() {
        layoutHeaderView()
        layoutPageTitle()
        layoutEditButton()
        layoutCategoriesTableView()
        layoutDropMenuView()
    }

    private func setupBackground() {
        self.view.backgroundColor = GlobalColors.backgroundColor
    }

    // MARK: HeaderView
    private func setupHeaderView() {
        let view = UIView()
        self.headerView = view
        self.view.addSubview(headerView)
    }

    private func layoutHeaderView() {
        headerView.backgroundColor = GlobalColors.mainBlueScreen
        self.headerView.pin
            .top()
            .left()
            .right()
            .height(14%)
        // headerView.roundLowerCorners(40)
        // headerView.dropShadow()
    }

    // MARK: Page Title
    private func setupPageTitle() {
        let label = UILabel()
        self.pageTitle = label
        pageTitle.numberOfLines = 2
        pageTitle.textAlignment = .center
        pageTitle.text = "Мои предметы"
        pageTitle.font = UIFont(name: "DMSans-Bold", size: 25)
        headerView.addSubview(pageTitle)
    }

    private func layoutPageTitle() {
        pageTitle.textColor = GlobalColors.backgroundColor
        pageTitle.pin
            .hCenter()
            .vCenter().marginTop(10%)
            .sizeToFit()
    }

    // MARK: edit Button

    private func setupEditButton() {
        let button = UIButton()

        moreButton = button

        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        headerView.addSubview(moreButton)
    }

    private func layoutEditButton() {
        moreButton.setImage(UIImage(named: "more",
                                        in: Bundle.main,
                                        with: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        moreButton.tintColor = GlobalColors.backgroundColor
        moreButton.contentVerticalAlignment = .fill
        moreButton.contentHorizontalAlignment = .fill
        moreButton.pin
            .height(25)
            .width(25)
            .top(pageTitle.frame.midY - moreButton.bounds.height / 2)
            .right(5%)
    }

    // MARK: categories table view

    private func setupCategoriesTableView() {
        let refreshControl = UIRefreshControl()
        let tableView = UITableView.customTableView()
        categoriesTableView = tableView
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.separatorStyle = .none
        categoriesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didRefreshRequested), for: .valueChanged)
        categoriesTableView.register(ItemCollectionCell.self, forCellReuseIdentifier: ItemCollectionCell.reuseIdentifier)
        categoriesTableView.contentInset = UIEdgeInsets(top: 10,
                                                  left: 0,
                                                  bottom: 0,
                                                  right: 0)
        categoriesTableView.setContentOffset(CGPoint(x: .zero, y: -10), animated: true)

        view.addSubview(categoriesTableView)
    }

    private func layoutCategoriesTableView() {
        if let tabbar = tabBarController?.tabBar {
            categoriesTableView.pin
                .below(of: headerView)// .marginTop(8)
                .left()
                .right()
                .above(of: tabbar)
        } else {
            categoriesTableView.pin
                .below(of: headerView)
                .left()
                .right()
                .bottom()
        }
    }

    // MARK: Drop Menu
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

    private func setupDropMenuView() {
        let menu = AllClothesDropDownView()// LookSettingsMenuView()

        dropMenuView = menu
        view.addSubview(dropMenuView)

        dropMenuView.output = output
        dropMenuView.dropShadow()
        dropMenuView.isUserInteractionEnabled = true
    }

    private func showDropDownMenu() {
        dropMenuView.pin
            .below(of: moreButton)
            .marginTop(20)
            .right(10)
            .height(0)
            .width(0)
        UIView.animate(withDuration: 0.3) {
            self.dropMenuView.pin
                .below(of: self.moreButton)
                .marginTop(20)
                .right(10)
                .height(13%)
                .width(43%)
            self.view.layoutIfNeeded()
        }
    }

    private func hideDropDownMenu() {
        dropMenuView.pin
            .below(of: moreButton)
            .marginTop(20)
            .right(10)
            .height(13%)
            .width(43%)
        UIView.animate(withDuration: 0.3) {
            self.dropMenuView.pin
                .below(of: self.moreButton)
                .marginTop(20)
                .right(10)
                .height(0)
                .width(0)
            self.view.layoutIfNeeded()
        }
    }

    // MARK: Gesture Recognizers
    private func setupGestureRecognizers() {
        tapOnMainViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMoreButton))
        self.categoriesTableView.isUserInteractionEnabled = true
        tapOnMainViewGestureRecognizer.isEnabled = false
        tapOnMainViewGestureRecognizer.numberOfTapsRequired = 1
        categoriesTableView.addGestureRecognizer(tapOnMainViewGestureRecognizer)

        tapOnHeaderViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMoreButton))
        tapOnHeaderViewGestureRecognizer.numberOfTapsRequired = 1
        tapOnHeaderViewGestureRecognizer.isEnabled = false
        headerView.addGestureRecognizer(tapOnHeaderViewGestureRecognizer)
    }

    private func enableGesture() {
        tapOnMainViewGestureRecognizer.isEnabled = true
        tapOnHeaderViewGestureRecognizer.isEnabled = true
    }

    private func disableGesture() {
        tapOnMainViewGestureRecognizer.isEnabled = false
        tapOnHeaderViewGestureRecognizer.isEnabled = false
    }

}

extension AllClothesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.getCategoriesCount() ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GlobalConstants.cellSize.height * 1.3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = categoriesTableView.dequeueReusableCell(
                withIdentifier: ItemCollectionCell.reuseIdentifier, for: indexPath) as? ItemCollectionCell
        else {
            return UITableViewCell()
        }
        guard let presenter = self.output else { return UITableViewCell() }
        cell.setData(output: presenter, index: indexPath.row, editMode: editMode)
        return cell
    }

}

extension AllClothesViewController: AllClothesViewInput {
    func tableViewScrollTo(row: Int) {
        categoriesTableView?.scrollToRow(at: IndexPath(row: row, section: 0), at: .top, animated: true)
    }

    func getEditMode() -> Bool {
        return self.editMode
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

    func toggleEditMode() {
        editMode.toggle()
    }

    func reloadData() {
        self.categoriesTableView.refreshControl?.endRefreshing()
        self.categoriesTableView.reloadData()
    }

    func changeEditButton(state: EditButtonState) {
        switch state {
        case .edit:
            moreButton.setImage(UIImage(named: "more",
                                         in: Bundle.main,
                                         with: UIImage.SymbolConfiguration(weight: .bold)),
                                         for: .normal)
            moreButton.removeTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
            moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        case .accept:
            moreButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            moreButton.removeTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
            moreButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        }
    }
}
