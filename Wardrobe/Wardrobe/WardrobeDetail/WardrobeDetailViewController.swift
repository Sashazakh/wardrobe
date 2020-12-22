import UIKit
import PinLayout

final class WardrobeDetailViewController: UIViewController {
	var output: WardrobeDetailViewOutput?

    private weak var headerView: UIView!
    private weak var titleLabel: UILabel!
    private weak var backButton: UIButton!
    private weak var personButton: UIButton!
    private weak var collectionView: UICollectionView!

    private var countOfCells = 20
    private let screenBounds = UIScreen.main.bounds

	override func viewDidLoad() {
		super.viewDidLoad()

        setupViews()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupLayout()
    }

    private func setupViews() {
        setupHeaderView()
        setupTitleLabel()
        setupBackButton()
        setupPersonButton()
        setupMainView()
        setupCollectionView()
    }

    private func setupLayout() {
        setupHeaderViewLayout()
        setupTitleLableLayout()
        setupBackButtonLayout()
        setupPersonButtonLayout()
        setupCollectionLayout()
        setupFlowLayout()
    }

    // MARK: Settuping views

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
        titleLabel.text = "Гардероб \n \"Работа\""
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
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = GlobalColors.backgroundColor
        backButton.contentVerticalAlignment = .fill
        backButton.contentHorizontalAlignment = .fill
        backButton.addTarget(self, action: #selector(didBackButtonTapped(_:)), for: .touchUpInside)
        headerView.addSubview(backButton)
    }

    private func setupPersonButton() {
        let btn = UIButton()
        personButton = btn
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold)
        personButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        personButton.setImage(UIImage(systemName: "person.3.fill"), for: .normal)
        personButton.tintColor = GlobalColors.backgroundColor
        personButton.contentVerticalAlignment = .fill
        personButton.contentHorizontalAlignment = .fill
        personButton.addTarget(self, action: #selector(didPersonButtonTabbed(_:)), for: .touchUpInside)
        headerView.addSubview(personButton)
    }

    private func setupCollectionView() {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView = collection
        collectionView.backgroundColor = .white
        collectionView.register(WardrobeCell.self, forCellWithReuseIdentifier: WardrobeCell.identifier)
        collectionView.register(AddWardrobeCell.self, forCellWithReuseIdentifier: AddWardrobeCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
    }

    // MARK: Setup layout

    private func setupHeaderViewLayout() {
        headerView.pin
            .top()
            .right()
            .left()
            .height(18%)
    }

    private func setupTitleLableLayout() {
        titleLabel.pin
            .hCenter()
            .top(38%)
            .height(50%)
    }

    private func setupBackButtonLayout() {
        backButton.pin
            .height(titleLabel.frame.height * 0.364)
            .width(5%)
            .vCenter()
            .left(3%)
    }

    private func setupPersonButtonLayout() {
        personButton.sizeToFit()
        personButton.pin
            .vCenter()
            .right(4.8%)
            .height(28)
            .width(31)
    }

    private func setupCollectionLayout() {
        collectionView.pin
            .below(of: headerView)
            .right()
            .left()
            .bottom()
    }

    private func setupFlowLayout() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let marginSides = screenBounds.width * 0.1
            let marginBottom = screenBounds.height * 0.041
            flowLayout.minimumInteritemSpacing = marginBottom
            flowLayout.minimumLineSpacing = marginSides
            flowLayout.scrollDirection = .vertical
        }
    }

    // MARK: Button actions

    @objc func didPersonButtonTabbed(_ sender: Any) {
        output?.personDidTap()
    }

    @objc func didBackButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WardrobeDetailViewController: WardrobeDetailViewInput {
}

extension WardrobeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WardrobeCell.identifier, for: indexPath)
        if indexPath.row == countOfCells - 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddWardrobeCell.identifier, for: indexPath)
            return cell
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)
    -> CGSize {
        return GlobalConstants.cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int)
    -> UIEdgeInsets {
        let marginSides = screenBounds.width * 0.1
        let marginTop = screenBounds.height * 0.05
        return UIEdgeInsets(top: marginTop, left: marginSides, bottom: 5, right: marginSides)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                cell.transform = CGAffineTransform.identity
            }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == countOfCells - 1 {
            output?.didTapCreateLookCell()
        } else {
            output?.didTapLook()
        }
    }
}
