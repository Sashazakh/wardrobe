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
    private weak var editButton: UIButton!

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
        setupAvatarView()
        setupNameLabel()
        setupCollectionView()
        setupActivityIndicatorView()
    }

    private func setupViewsLayout() {
        setupHeaderViewLayout()
        setupTitleLabelLayout()
        setupSettingsButtonLayout()
        setupEditButtonLayout()
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
        avatarImageView.dropShadow()
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = GlobalColors.backgroundColor
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
            .before(of: titleLabel, aligned: .center)
            .margin(23%)
            .width(titleLabel.frame.height * 0.7)
            .height(titleLabel.frame.height * 0.7)
    }

    private func setupEditButtonLayout() {
        editButton.pin
            .after(of: titleLabel, aligned: .center)
            .margin(23%)
            .width(titleLabel.frame.height * 0.8)
            .height(titleLabel.frame.height * 0.8)
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

    @objc private func didEditButtonTapped(_ sender: Any) {
        output?.didEditButtonTap()
    }
}

extension MainScreenViewController: MainScreenViewInput {
    func changeEditButton(state: EditButtonState) {
        func changeEditButton(state: EditButtonState) {
            switch state {
            case .edit:
                editButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
            case .accept:
                editButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            }
        }
    }

    func reloadDataWithAnimation() {
        isReloadDataNeed = true
        collectionView.reloadData()
    }

    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }

    func setUserName(name: String?) {
        if let name = name {
            let text = name.split(separator: " ")
            nameLabel.text = text.joined(separator: "\n")
        }
    }

    func setUserImage(with imageUrl: URL?) {
        if let imageUrl = imageUrl {
            avatarImageView.kf.setImage(with: imageUrl)
        } else {
            avatarImageView.image = UIImage(named: "no_photo")
            avatarImageView.contentMode = .bottom
        }
    }

    func reloadData() {
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

            cell.configureCell(wardobeData: wardobe, output: output)
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
        guard var countOfCells = output?.getNumberOfWardrobes() else { return }
        countOfCells += 1
        if isReloadDataNeed {
            if indexPath.row != countOfCells - 1 {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                    UIView.animate(withDuration: 0.3) {
                        cell.transform = CGAffineTransform.identity
                    }
            } else {
                isReloadDataNeed = !isReloadDataNeed
            }
        } else {
            cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                UIView.animate(withDuration: 0.4) {
                    cell.transform = CGAffineTransform.identity
                }
        }
    }
}
