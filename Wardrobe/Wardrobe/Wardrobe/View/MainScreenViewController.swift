import UIKit
import PinLayout

final class MainScreenViewController: UIViewController {
    var output: MainScreenViewOutput?

    private weak var headerView: UIView!
    private weak var titleLabel: UILabel!
    private weak var settingsButton: UIButton!
    private weak var collectionView: UICollectionView!
    private weak var editButton: UIButton!
    private let refreshControl = UIRefreshControl()

    private let screenBounds = UIScreen.main.bounds

    private var activityIndicatorView: UIActivityIndicatorView!

    private var isReloadDataNeed: Bool = false

    // MARK: Vc lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupViewsLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        output?.didLoadView()
    }

    private func setupViews() {
        setupMainView()
        setupHeaderView()
        setupLabelView()
        setupSettingsButton()
        setupEditButton()
        setupCollectionView()
        setupActivityIndicatorView()
    }

    private func setupViewsLayout() {
        setupHeaderViewLayout()
        setupTitleLabelLayout()
        setupSettingsButtonLayout()
        setupEditButtonLayout()
        setupCollectionLayout()
        setupFlowLayout()
    }
    // MARK: setup views

    private func setupMainView() {
        view.backgroundColor = GlobalColors.backgroundColor
    }

    private func setupHeaderView() {
        let view = UIView()
        headerView = view
        headerView.backgroundColor = GlobalColors.mainBlueScreen
//        headerView.dropShadow()
//        headerView.roundLowerCorners(40)
        self.view.addSubview(headerView)
    }

    private func setupSettingsButton() {
        let button = UIButton()
        settingsButton = button
        settingsButton.setImage(UIImage(systemName: "gearshape.fill"),
                                for: .normal)
        settingsButton.tintColor = GlobalColors.backgroundColor
        settingsButton.contentVerticalAlignment = .fill
        settingsButton.contentHorizontalAlignment = .fill
        settingsButton.addTarget(self, action: #selector(didSettingsButtonTapped(_:)),
                                 for: .touchUpInside)
        self.headerView.addSubview(settingsButton)
    }

    private func setupLabelView() {
        let label = UILabel()
        titleLabel = label
        titleLabel.text = "Гардеробы"
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        titleLabel.textColor = GlobalColors.backgroundColor
        titleLabel.textAlignment = .center
        headerView.addSubview(titleLabel)
    }

    private func setupCollectionView() {
        let collView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView = collView
        collectionView.backgroundColor = .white
        collectionView.register(MainScreenCell.self,
                                forCellWithReuseIdentifier: "MainScreenCell")
        collectionView.register(AddWardrobeCell.self,
                                forCellWithReuseIdentifier: AddWardrobeCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        view.addSubview(collectionView)
    }

    private func setupActivityIndicatorView() {
        let activ = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        activityIndicatorView = activ
        activityIndicatorView.color = .black
        activityIndicatorView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2,
                                               y: UIScreen.main.bounds.size.height / 2)
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
    }

    private func setupEditButton() {
        let editBtn = UIButton()
        editButton = editBtn
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold)
        editButton.setImage(UIImage(systemName: "square.and.pencil"),
                                for: .normal)
        editButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        editButton.tintColor = GlobalColors.backgroundColor
        editButton.contentVerticalAlignment = .fill
        editButton.contentHorizontalAlignment = .fill
        editButton.addTarget(self, action: #selector(didEditButtonTapped(_:)),
                                 for: .touchUpInside)
        self.headerView.addSubview(editButton)
    }

    // MARK: layout

    private func setupHeaderViewLayout() {
        headerView.pin
            .top()
            .right()
            .left()
            .height(16%)
    }

    private func setupTitleLabelLayout() {
        titleLabel.pin
            .top(40%)
            .hCenter()
            .width(70%)
            .height(50)
    }

    private func setupSettingsButtonLayout() {
        settingsButton.pin
            .height(27)
            .width(27)

        settingsButton.pin
            .top(titleLabel.frame.midY - settingsButton.bounds.height / 2)
            .left(7%)
    }

    private func setupEditButtonLayout() {
        editButton.pin
            .height(27)
            .width(27)

        editButton.pin
            .top(titleLabel.frame.midY - editButton.bounds.height / 2)
            .right(7%)
    }

    private func setupCollectionLayout() {
        collectionView.pin
            .below(of: headerView)
            .right()
            .left()
            .bottom()
    }

    private func setupFlowLayout() {
        collectionView.contentInset = UIEdgeInsets(top: 10,
                                                   left: .zero,
                                                   bottom: .zero,
                                                   right: .zero)

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let marginSides = screenBounds.width * 0.1
            let marginBottom = screenBounds.height * 0.041
            flowLayout.minimumInteritemSpacing = marginBottom
            flowLayout.minimumLineSpacing = marginSides
            flowLayout.scrollDirection = .vertical
        }
    }

    // MARK: Actions

    @objc private func didSettingsButtonTapped(_ sender: Any) {
        output?.settingsButtonDidTap()
    }

    @objc private func didEditButtonTapped(_ sender: Any) {
        output?.didEditButtonTap()
    }

    @objc private func refreshData(_ sender: Any) {
        output?.refreshData()
    }
}

extension MainScreenViewController: MainScreenViewInput {
    func changeEditButton(state: EditButtonState) {
        switch state {
        case .edit:
            editButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        case .accept:
            editButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
    }

    func reloadDataWithAnimation() {
        refreshControl.endRefreshing()
        isReloadDataNeed = true
        collectionView.reloadData()
    }

    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }

    func reloadData() {
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }

    func startActivity() {
        activityIndicatorView.startAnimating()
    }

    func endActivity() {
        activityIndicatorView.stopAnimating()
    }
}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var totalNumberOfCells = output?.getNumberOfWardrobes() ?? 0
        totalNumberOfCells += 1
        return totalNumberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var numberOfWardobes = output?.getNumberOfWardrobes() ?? 0
        numberOfWardobes += 1
        if indexPath.row == numberOfWardobes - 1 || numberOfWardobes == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddWardrobeCell.identifier, for: indexPath)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainScreenCell", for: indexPath) as? MainScreenCell else {
                return UICollectionViewCell()
            }

            guard let wardobe = output?.wardrobe(at: indexPath) else {
                return UICollectionViewCell()
            }

            cell.configureCell(wardobeData: wardobe,
                               output: output)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)
    -> CGSize {
        return GlobalConstants.cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int)
    -> UIEdgeInsets {
        let marginSides = screenBounds.width * 0.1
        return UIEdgeInsets(top: 5, left: marginSides, bottom: 5, right: marginSides)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var numberOfWardobes = output?.getNumberOfWardrobes() ?? 0
        numberOfWardobes += 1
        if indexPath.row == numberOfWardobes - 1 || numberOfWardobes == 0 {
            output?.addWardrobeDidTap()
        } else {
            guard let isEditButtonTapped = output?.isEditButtonTapped() else { return }
            if isEditButtonTapped {
                output?.didEditWardrobeTap(at: indexPath)
            } else {
                output?.showDetailDidTap(at: indexPath)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard var countOfCells = output?.getNumberOfWardrobes() else { return }
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
}
