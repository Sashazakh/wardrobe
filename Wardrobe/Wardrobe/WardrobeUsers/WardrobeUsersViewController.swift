import UIKit
import PinLayout

enum EditButtonState: Int {
    case edit = 0, accept
}

final class WardrobeUsersViewController: UIViewController {
	var output: WardrobeUsersViewOutput?

    private weak var headerView: UIView!
    private weak var titleLabel: UILabel!
    private weak var backButton: UIButton!
    private weak var collectionView: UICollectionView!
    private weak var editButton: UIButton!
    private let refreshControl = UIRefreshControl()

    private let screenBounds = UIScreen.main.bounds

    private var isReloadDataNeed: Bool = false

	override func viewDidLoad() {
		super.viewDidLoad()

        setupViews()
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        output?.didLoadView()
    }

    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()

        setupViewsLayout()
    }

    private func setupViews() {
        setupMainView()
        setupHeaderView()
        setupTitleLabel()
        setupBackButton()
        setupCollectionView()
        setupEditButton()
    }

    private func setupViewsLayout() {
        setupHeaderViewLayout()
        setupTitleLableLayout()
        setupBackButtonLayout()
        setupCollectionViewLayout()
        setupEditButtonLayout()

    }

    // MARK: Setup views

    private func setupMainView() {
        view.backgroundColor = GlobalColors.backgroundColor
    }

    private func setupHeaderView() {
        let viewHeader = UIView()
        headerView = viewHeader
        headerView.backgroundColor = GlobalColors.mainBlueScreen
//        headerView.dropShadow()
//        headerView.roundLowerCorners(40)
        view.addSubview(headerView)
    }

    private func setupTitleLabel() {
        let title = UILabel()
        titleLabel = title
        titleLabel.text = "Участники гардероба\n"
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        titleLabel.textColor = GlobalColors.backgroundColor
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.1
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        headerView.addSubview(titleLabel)
    }

    private func setupBackButton() {
        let btn = UIButton()
        backButton = btn

        backButton.setImage(UIImage(systemName: "chevron.backward",
                                    withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                    for: .normal)
        backButton.tintColor = GlobalColors.backgroundColor
        backButton.contentVerticalAlignment = .fill
        backButton.contentHorizontalAlignment = .fill
        backButton.addTarget(self, action: #selector(didBackButtonTapped(_:)), for: .touchUpInside)
        headerView.addSubview(backButton)
    }

    private func setupCollectionView() {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView = collection
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = true
        collectionView.register(WardrobeUsersCell.self, forCellWithReuseIdentifier: WardrobeUsersCell.identifier)
        collectionView.register(AddUserCell.self, forCellWithReuseIdentifier: AddUserCell.identifier)
        collectionView.backgroundColor = GlobalColors.backgroundColor
        collectionView.showsVerticalScrollIndicator = false

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        view.addSubview(collectionView)
    }

    private func setupEditButton() {
        let btn = UIButton()
        editButton = btn
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold)
        editButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        editButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        editButton.tintColor = GlobalColors.backgroundColor
        editButton.contentVerticalAlignment = .fill
        editButton.contentHorizontalAlignment = .fill
        editButton.addTarget(self, action: #selector(didEditButtonTapped(_:)), for: .touchUpInside)
        headerView.addSubview(editButton)
    }

    // MARK: Setuplayout

    private func setupHeaderViewLayout() {
        headerView.pin
            .top(.zero)
            .width(100%)
            .height(16%)
    }

    private func setupTitleLableLayout() {
        titleLabel.pin
            .top(40%)
            .hCenter()
            .width(80%)
            .height(50)
    }

    private func setupBackButtonLayout() {
        backButton.pin
            .height(25)
            .width(20)

        backButton.pin
            .top(titleLabel.frame.midY - backButton.bounds.height / 2)
            .left(5%)
    }

    private func setupCollectionViewLayout() {
        collectionView.pin
            .below(of: headerView)
            .left()
            .right()
            .bottom()
    }

    private func setupEditButtonLayout() {
        editButton.pin
            .height(25)
            .width(25)

        editButton.pin
            .top(titleLabel.frame.midY - editButton.bounds.height / 2)
            .right(5%)
    }

    // MARK: Actions

    @objc func didBackButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func didEditButtonTapped(_ sender: Any) {
        output?.didEditButtonTap()
    }

    @objc func refreshData(_ sender: Any) {
        output?.refreshData()
    }
}

extension WardrobeUsersViewController: WardrobeUsersViewInput {
    func setWardrobeName(with name: String) {
        guard var text = titleLabel.text else { return }
        text += "\"\(name)\""
        titleLabel.text = text
    }

    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }

    func reloadDataWithAnimation() {
        refreshControl.endRefreshing()
        isReloadDataNeed = true
        collectionView.reloadData()
    }

    func reloadData() {
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }

    func changeEditButton(state: EditButtonState) {
        switch state {
        case .edit:
            editButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        case .accept:
            editButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
    }
}

extension WardrobeUsersViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                                       UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        var totalNumberOfCells = output?.getNumberOfUsers() ?? 0
        totalNumberOfCells += 1
        return totalNumberOfCells
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var numberOfLooks = output?.getNumberOfUsers() ?? 0
        numberOfLooks += 1
        if indexPath.row == numberOfLooks - 1 || numberOfLooks == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                                    AddUserCell.identifier,
                                                                    for: indexPath)
                                                                    as? AddUserCell
            else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                                    WardrobeUsersCell.identifier,
                                                                    for: indexPath)
                                                                    as? WardrobeUsersCell
            else { return UICollectionViewCell() }

            guard let user = output?.getWardrobeUser(at: indexPath) else {
                return UICollectionViewCell()
            }

            cell.configureCell(wardrobeUser: user,
                               output: output)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = screenBounds.width * 0.354
        let cellHeight = screenBounds.height * 0.2558
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int)
    -> UIEdgeInsets {
        let marginSides = screenBounds.width * 0.098
        let marginTop = screenBounds.height * 0.04
        return UIEdgeInsets(top: marginTop, left: marginSides, bottom: 5, right: marginSides)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard var countOfCells = output?.getNumberOfUsers() else { return }
        countOfCells += 1
        if isReloadDataNeed {
            if indexPath.row == countOfCells - 1 {
                isReloadDataNeed = !isReloadDataNeed
            }
        } else {
            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                UIView.animate(withDuration: 0.5) {
                    cell.transform = CGAffineTransform.identity
                }
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let count = output?.getNumberOfUsers() else { return }
        if indexPath.row == count {
            output?.didInivteUserButtonTapped()
        }
    }
}
