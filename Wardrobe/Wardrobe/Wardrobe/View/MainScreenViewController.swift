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
    private weak var surnameLabel: UILabel!
    private weak var collectionView: UICollectionView!

    private let screenBounds = UIScreen.main.bounds

    private var countOfCells = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupHeaderViewLayout()
        setupTitleLabelLayout()
        setupSettingsButtonLayout()
        setupAvatarViewLayout()
        setupNameLabelLayout()
        setupSurnameLayout()
        setupCollectionLayout()
        setupFlowLayout()
    }

    // MARK: setup views
    private func setupViews() {
        setupMainView()
        setupHeaderView()
        setupLabelView()
        setupSettingsButton()
        setupAvatarView()
        setupNameLabel()
        setupSurnameLabel()
        setupCollectionView()
    }

    private func setupMainView() {
        view.backgroundColor = GlobalColors.backgroundColor
    }

    private func setupHeaderView() {
        let view = UIView()
        headerView = view
        headerView.backgroundColor = GlobalColors.mainBlueScreen
        headerView.dropShadow()
        headerView.roundLowerCorners(40)
        self.view.addSubview(headerView)
    }

    private func setupSettingsButton() {
        let button = UIButton()
        settingsButton = button
        settingsButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        settingsButton.tintColor = GlobalColors.backgroundColor
        settingsButton.contentVerticalAlignment = .fill
        settingsButton.contentHorizontalAlignment = .fill
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
        nameLabel.text = "Морж"
        nameLabel.textColor = GlobalColors.darkColor
        nameLabel.font = UIFont(name: "DMSans-Bold", size: 15)
        self.view.addSubview(nameLabel)
    }

    private func setupSurnameLabel() {
        let label = UILabel()
        surnameLabel = label
        surnameLabel.text = "Моржов"
        surnameLabel.textColor = GlobalColors.darkColor
        surnameLabel.font = UIFont(name: "DMSans-Bold", size: 15)
        self.view.addSubview(surnameLabel)
    }

    private func setupCollectionView() {
        let collView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView = collView
        collectionView.backgroundColor = .white
        collectionView.register(WardrobeCell.self, forCellWithReuseIdentifier: WardrobeCell.identifier)
        collectionView.register(AddWardrobeCell.self, forCellWithReuseIdentifier: AddWardrobeCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
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
            .margin(1.3%)
            .sizeToFit()
    }

    private func setupSurnameLayout() {
        surnameLabel.pin
            .below(of: nameLabel, aligned: .center)
            .marginTop(0.5%)
            .sizeToFit()
    }

    private func setupCollectionLayout() {
        collectionView.pin
            .top(41.871%)
            .right()
            .left()
            .bottom()
    }

    private func setupFlowLayout() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let marginSides = screenBounds.width * 0.069
            let marginBottom = screenBounds.height * 0.041
            flowLayout.minimumInteritemSpacing = marginBottom
            flowLayout.minimumLineSpacing = marginSides
            flowLayout.scrollDirection = .vertical
        }
    }
}

extension MainScreenViewController: MainScreenViewInput {
}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource,
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
        let cellWidth = screenBounds.width * 0.23
        let cellHeight = screenBounds.height * 0.15
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int)
    -> UIEdgeInsets {
        let marginSides = screenBounds.width * 0.053
        return UIEdgeInsets(top: 5, left: marginSides, bottom: 5, right: marginSides)
    }
}
