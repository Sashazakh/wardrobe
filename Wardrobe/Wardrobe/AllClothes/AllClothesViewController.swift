import UIKit
import PinLayout

final class AllClothesViewController: UIViewController {

    private weak var headerView: UIView!
    private weak var editButton: UIButton!
    private weak var pageTitle: UILabel!
    private weak var categoriesTableView: UITableView!
    private let screenBounds = UIScreen.main.bounds

	var output: AllClothesViewOutput?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        setupUI()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }
}

extension AllClothesViewController {
    private func setupUI() {
        setupBackground()
        setupHeaderView()
        setupPageTitle()
        setupEditButton()
        setupCategoriesTableView()
    }

    private func layoutUI() {
        layoutHeaderView()
        layoutPageTitle()
        layoutEditButton()
        layoutCategoriesTableView()
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
        headerView.pin
            .top()
            .left()
            .right()
            .height(23.275%)
        UIView.animate(withDuration: 0.2) {
            self.headerView.pin
                .top()
                .left()
                .right()
                .height(14%)
        }
        //headerView.roundLowerCorners(40)
        //headerView.dropShadow()
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
        self.editButton = button
        editButton.isUserInteractionEnabled = true
        headerView.addSubview(editButton)
    }

    private func layoutEditButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold)
        editButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        editButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        editButton.tintColor = GlobalColors.backgroundColor
        editButton.contentVerticalAlignment = .fill
        editButton.contentHorizontalAlignment = .fill
        editButton.pin
            .after(of: pageTitle, aligned: .center)
            .marginLeft(12%)
            .width(pageTitle.frame.height * 0.7)
            .height(pageTitle.frame.height * 0.7)
    }

    // MARK: categories table view

    private func setupCategoriesTableView() {
        let tableView = UITableView.customTableView()
        categoriesTableView = tableView
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.separatorStyle = .none
        categoriesTableView.register(ItemCollectionCell.self, forCellReuseIdentifier: ItemCollectionCell.reuseIdentifier)
        view.addSubview(categoriesTableView)
    }

    private func layoutCategoriesTableView() {
        if let tabbar = tabBarController?.tabBar {
            categoriesTableView.pin
                .below(of: headerView)//.marginTop(8)
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
}

extension AllClothesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenBounds.width * 0.32 * 1.072 * 1.45
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: ItemCollectionCell.reuseIdentifier, for: indexPath)
        return cell
    }

}

extension AllClothesViewController: AllClothesViewInput {
}
