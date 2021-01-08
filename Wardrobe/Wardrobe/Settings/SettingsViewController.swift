import UIKit
import PinLayout

enum SettingsSections: Int, CaseIterable {
    case  myInvites = 0, changeLogin, changePassword, logout

    var info: String {
        switch self {
        case .myInvites:
            return "Мои приглашения"
        case .changeLogin:
            return "Изменить логин"
        case .changePassword:
            return "Изменить пароль"
        case .logout:
            return "Выйти"
        }
    }
}

final class SettingsViewController: UIViewController {
	var output: SettingsViewOutput?

    private weak var headerView: UIView!
    private weak var titleLabel: UILabel!
    private weak var backButton: UIButton!
    private weak var outerImageView: UIView!
    private weak var avatarImageView: UIImageView!
    private weak var imageButton: UIButton!
    private weak var userLoginLabel: UILabel!
    private weak var tableView: UITableView!
    private let pickerController: UIImagePickerController = UIImagePickerController()

    private var opacityImage: UIImage?
//    private let screenBounds = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        output?.didLoadView()
    }

    private func setupViews() {
        setupMainView()
        setupHeaderView()
        setupTitleLabel()
        setupBackButton()
        setupAvatarView()
        setupImageButton()
        setupUserLoginLabel()
        setupImagePicker()
        setupTableView()
    }

    private func setupLayout() {
        setupHeaderViewLayout()
        setupTitleLableLayout()
        setupBackButtonLayout()
        setupAvatarViewLayout()
        setupUserLoginLayout()
        setupTableViewLayout()
    }

    // MARK: Setupping views
    private func setupMainView() {
        view.backgroundColor = GlobalColors.backgroundColor
    }

    private func setupHeaderView() {
        let viewHeader = UIView()
        headerView = viewHeader
        headerView.backgroundColor = GlobalColors.mainBlueScreen
//        headerView.dropShadow()
//        headerView.roundLowerCorners(40)
        self.view.addSubview(headerView)
    }

    private func setupTitleLabel() {
        let title = UILabel()
        titleLabel = title
        titleLabel.text = "Настройки"
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        titleLabel.textColor = GlobalColors.backgroundColor
        headerView.addSubview(titleLabel)
    }

    private func setupBackButton() {
        let btn = UIButton()
        backButton = btn
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold)
        backButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        backButton.tintColor = GlobalColors.backgroundColor
        backButton.contentVerticalAlignment = .fill
        backButton.contentHorizontalAlignment = .fill
        backButton.addTarget(self, action: #selector(didBackButtonTapped(_:)), for: .touchUpInside)
        headerView.addSubview(backButton)
    }

    private func setupAvatarView() {
        setupOuterView()
        let imageView = UIImageView()
        avatarImageView = imageView
        avatarImageView.dropShadow()
        avatarImageView.clipsToBounds = true
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.contentMode = .scaleToFill
        outerImageView.addSubview(avatarImageView)
    }

    private func setupOuterView() {
        let view = UIView()
        outerImageView = view
        outerImageView.clipsToBounds = false
        outerImageView.dropShadow()
        outerImageView.isUserInteractionEnabled = true
        outerImageView.layer.borderWidth = 4
        outerImageView.layer.borderColor = GlobalColors.backgroundColor.cgColor
        outerImageView.backgroundColor = GlobalColors.darkColor
        self.view.addSubview(outerImageView)
    }

    private func setupImageButton() {
        let btn = UIButton()
        imageButton = btn
        imageButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        imageButton.tintColor = GlobalColors.backgroundColor
        imageButton.contentVerticalAlignment = .fill
        imageButton.contentHorizontalAlignment = .fill
        imageButton.addTarget(self, action: #selector(addImageAction(_:)), for: .touchUpInside)
        imageButton.isUserInteractionEnabled = true
        outerImageView.addSubview(imageButton)
    }

    private func setupImagePicker() {
        pickerController.delegate = self
        pickerController.allowsEditing = false
    }

    private func setupUserLoginLabel() {
        let lbl = UILabel()
        userLoginLabel = lbl
        userLoginLabel.textColor = GlobalColors.darkColor
        userLoginLabel.textAlignment = .center
        userLoginLabel.font = UIFont(name: "DMSans-Bold", size: 15)
        self.view.addSubview(userLoginLabel)
    }

    private func setupTableView() {
        let table = UITableView()
        tableView = table
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = GlobalColors.backgroundColor
        tableView.separatorStyle = .none
        tableView.register(SettingsTableViewCell.self,
                           forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = GlobalColors.backgroundColor
        view.addSubview(tableView)
    }

    // MARK: Setup layout

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
            .height(25)
            .width(20)

        backButton.pin
            .top(titleLabel.frame.midY - backButton.bounds.height / 2)
            .left(3%)
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
        outerImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.alpha = 0.3

        imageButton.pin.all()
        let width = imageButton.frame.width * 0.35
        let height = imageButton.frame.height * 0.35
        imageButton.imageEdgeInsets = UIEdgeInsets(top: height,
                                                   left: width,
                                                   bottom: height,
                                                   right: width)
    }

    private func setupUserLoginLayout() {
        userLoginLabel.pin
            .below(of: outerImageView, aligned: .center)
            .marginTop(1.3%)
            .width(95%)
            .height(17)
    }

    private func setupTableViewLayout() {
        tableView.pin
            .below(of: userLoginLabel)
            .marginTop(3%)
            .left()
            .right()
            .bottom()
    }

    // MARK: Button actions

    @objc func didBackButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func addImageAction(_ sender: Any) {
        chooseHowToPickImage()
    }
}

extension SettingsViewController: SettingsViewInput {
    func setUserLogin(login: String?) {
        if let login = login {
            userLoginLabel.text = login
        }
    }

    func setUserImage(with imageUrl: URL?) {
        if let imageUrl = imageUrl {
            avatarImageView.kf.setImage(with: imageUrl, options: [.fromMemoryCacheOrRefresh])
        } else {
            avatarImageView.image = UIImage(named: "no_photo")
        }
    }

    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsSections.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell
        else {
            return UITableViewCell()
        }
        guard let label = SettingsSections(rawValue: indexPath.row)?.info else { return UITableViewCell() }
        cell.configureCell(label: label)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = GlobalConstants.screenBounds.height * 0.0881
        return height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SettingsSections(rawValue: indexPath.row) {
        case .myInvites:
            output?.didMyInvitesButtonTap()
        case .changeLogin:
            output?.didChangeLoginTapped()
        case .changePassword:
            output?.didChangePasswordTapped()
        case .logout:
            output?.didLogoutTapped()
        case .none:
            break
        }
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
            return UIAlertAction(title: title, style: .default) { [unowned self] _ in
                   pickerController.sourceType = type
                   present(self.pickerController, animated: true)
            }
           }

        private func chooseHowToPickImage() {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            if let action = self.action(for: .camera, title: "Камера") {
                       alertController.addAction(action)
            }
            if let action = self.action(for: .savedPhotosAlbum, title: "Галерея") {
                       alertController.addAction(action)
            }

            alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }

        private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
            controller.dismiss(animated: true, completion: nil)
            guard let img = image else {
                return
            }
            opacityImage = img
            output?.didImageLoaded(imageData: img.jpegData(compressionQuality: 0.1))
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            pickerController(picker, didSelect: nil)
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let image = info[.originalImage] as? UIImage else {
                pickerController(picker, didSelect: nil)
                return
            }
            pickerController(picker, didSelect: image)
        }
}
