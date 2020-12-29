import UIKit
import PinLayout

final class MainScreenViewController: UIViewController {
    var output: MainScreenViewOutput?
    private weak var headerView: UIView!
    private weak var titleLabel: UILabel!
    private weak var settingsButton: UIButton!
    private weak var avatarImageView: UIImageView!
    private weak var outerImageView: UIView!
    private weak var nameLabel: UILabel!
    private weak var collectionView: UICollectionView!

    private let screenBounds = UIScreen.main.bounds

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
        setupAvatarView()
        setupNameLabel()
        setupCollectionView()
    }

    private func setupViewsLayout() {
        setupHeaderViewLayout()
        setupTitleLabelLayout()
        setupSettingsButtonLayout()
        setupAvatarViewLayout()
        setupNameLabelLayout()
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
        headerView.addSubview(titleLabel)
    }

    private func setupAvatarView() {
        setupOuterView()
        let imageView = UIImageView()
        avatarImageView = imageView
        avatarImageView.layer.borderWidth = 4
        avatarImageView.layer.borderColor = GlobalColors.backgroundColor.cgColor
        avatarImageView.image = UIImage(named: "morz")
        avatarImageView.dropShadow()
        avatarImageView.clipsToBounds = true
        outerImageView.addSubview(avatarImageView)
    }

    private func setupOuterView() {
        let view = UIView()
        outerImageView = view
        outerImageView.clipsToBounds = false
        outerImageView.dropShadow()
        self.view.addSubview(outerImageView)
    }

    private func setupNameLabel() {
        let label = UILabel()
        nameLabel = label
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        nameLabel.textColor = GlobalColors.darkColor
        nameLabel.font = UIFont(name: "DMSans-Bold", size: 15)
        self.view.addSubview(nameLabel)
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
        view.addSubview(collectionView)
    }

    // MARK: layout
    private func setupHeaderViewLayout() {
        headerView.pin
            .top()
            .right()
            .left()
            .height(23.275%)
    }

    private func setupTitleLabelLayout() {
        titleLabel.pin
            .hCenter()
            .top(38%)
            .sizeToFit()
    }

    private func setupSettingsButtonLayout() {
        settingsButton.pin
            .after(of: titleLabel, aligned: .center)
            .margin(17%)
            .width(titleLabel.frame.height * 0.7)
            .height(titleLabel.frame.height * 0.7)
    }

    private func setupAvatarViewLayout() {
        let imgRadius = UIScreen.main.bounds.height * 0.1477
        outerImageView.pin
            .below(of: headerView)
            .margin(-imgRadius / 2)
            .hCenter()
            .height(imgRadius)
            .width(imgRadius)
        avatarImageView.pin.all()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }

    private func setupNameLabelLayout() {
        nameLabel.pin
            .below(of: outerImageView, aligned: .center)
            .marginTop(1.3%)
            .height(4.7%)
            .sizeToFit()
    }

    private func setupCollectionLayout() {
        collectionView.pin
            .below(of: [nameLabel])
            .right()
            .left()
            .bottom()

        let gradientLayerUp = CAGradientLayer()

        gradientLayerUp.frame = CGRect(x: .zero,
                                       y: collectionView.frame.minY,
                                       width: collectionView.bounds.width,
                                       height: 10)
        gradientLayerUp.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,
                                          UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor]
        view.layer.addSublayer(gradientLayerUp)

        let gradientLayerDown = CAGradientLayer()

        gradientLayerDown.frame = CGRect(x: .zero,
                                         y: collectionView.frame.maxY - 10,
                                         width: collectionView.bounds.width,
                                         height: 10)
        gradientLayerDown.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor,
                                        UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
        view.layer.addSublayer(gradientLayerDown)
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

    @objc private func didSettingsButtonTapped(_ sender: Any) {
        output?.settingsButtonDidTap()
    }
}

extension MainScreenViewController: MainScreenViewInput {
    func setUserData(name: String?, imageUrl: URL?) {
        if let name = name {
            let text = name.split(separator: " ")
            nameLabel.text = text.joined(separator: "\n")
        }
        if let imageUrl = imageUrl {
            avatarImageView.kf.setImage(with: imageUrl)
        }
    }

    func reloadData() {
        collectionView.reloadData()
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

            cell.configureCell(with: wardobe)
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
            output?.showDetailDidTap(at: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.4) {
                cell.transform = CGAffineTransform.identity
            }
    }
}
