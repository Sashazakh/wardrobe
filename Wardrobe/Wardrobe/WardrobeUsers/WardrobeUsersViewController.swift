import UIKit
import PinLayout

final class WardrobeUsersViewController: UIViewController {
	var output: WardrobeUsersViewOutput?

    private weak var headerView: UIView!
    private weak var titleLabel: UILabel!
    private weak var backButton: UIButton!
    private weak var collectionView: UICollectionView!
    private weak var editButton: UIButton!

    private let screenBounds = UIScreen.main.bounds

	override func viewDidLoad() {
		super.viewDidLoad()

        setupViews()
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
        headerView.dropShadow()
        headerView.roundLowerCorners(40)
        view.addSubview(headerView)
    }

    private func setupTitleLabel() {
        let title = UILabel()
        titleLabel = title
        titleLabel.text = "Участники\nгардероба" + "\n\"Собеседование\""
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        titleLabel.textColor = GlobalColors.backgroundColor
        headerView.addSubview(titleLabel)
    }

    private func setupBackButton() {
        let btn = UIButton()
        backButton = btn
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
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
        collectionView.register(WardrobeUsersCell.self, forCellWithReuseIdentifier: WardrobeUsersCell.identifier)
        collectionView.backgroundColor = GlobalColors.backgroundColor
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
        headerView.addSubview(editButton)
    }

    // MARK: Setuplayout

    private func setupHeaderViewLayout() {
        headerView.pin
            .top()
            .right()
            .left()
            .height(23.275%)
    }

    private func setupTitleLableLayout() {
        titleLabel.pin
            .hCenter()
            .top(38%)
            .sizeToFit()
    }

    private func setupBackButtonLayout() {
        backButton.pin
            .height(titleLabel.frame.height * 0.265)
            .width(5%)
            .before(of: titleLabel, aligned: .top)
            .left(3%)
    }

    private func setupCollectionViewLayout() {
        collectionView.pin
            .top(25.24%)
            .left()
            .right()
            .bottom()
    }

    private func setupEditButtonLayout() {
        editButton.pin
                    .after(of: titleLabel, aligned: .top)
                    .marginLeft(12%)
                    .width(titleLabel.frame.height * 0.344)
                    .height(titleLabel.frame.height * 0.344)
    }
    // MARK: Button actions

    @objc func didBackButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WardrobeUsersViewController: WardrobeUsersViewInput {
}

extension WardrobeUsersViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                                       UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WardrobeUsersCell.identifier, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)
    -> CGSize {
        let cellWidth = screenBounds.width * 0.32
        let cellHeight = screenBounds.height * 0.2216
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int)
    -> UIEdgeInsets {
        let marginSides = screenBounds.width * 0.098
        return UIEdgeInsets(top: 5, left: marginSides, bottom: 5, right: marginSides)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.4) {
                cell.transform = CGAffineTransform.identity
            }
    }

}
