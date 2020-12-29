import UIKit
import PinLayout

enum SettingsSections: Int, CaseIterable {
    case  myInvites = 0, changeName, logout

    var info: String {
        switch self {
        case .myInvites:
            return "Мои приглашения"
        case .changeName:
            return "Изменить имя"
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
    private weak var fullNameLabel: UILabel!
    private weak var tableView: UITableView!
    private let pickerController: UIImagePickerController = UIImagePickerController()

    private let screenBounds = UIScreen.main.bounds

	override func viewDidLoad() {
		super.viewDidLoad()

        setupViews()
        output?.didLoadView()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupLayout()
    }

    private func setupViews() {
        setupMainView()
        setupHeaderView()
        setupTitleLabel()
        setupBackButton()
        setupOuterView()
        setupAvatarView()
        setupImageButton()
        setupFullNameLabel()
        setupImagePicker()
        setupTableView()
    }

    private func setupLayout() {
        setupHeaderViewLayout()
        setupTitleLableLayout()
        setupBackButtonLayout()
        setupAvatarViewLayout()
        setupFullNameLayout()
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
        view.addSubview(headerView)
    }

    private func setupTitleLabel() {
        let title = UILabel()
        titleLabel = title
        titleLabel.text = "Настройки"
        titleLabel.numberOfLines = 0
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

    private func setupAvatarView() {
        let imageView = UIImageView()
        avatarImageView = imageView
        avatarImageView.layer.borderWidth = 4
        avatarImageView.layer.borderColor = GlobalColors.backgroundColor.cgColor
        avatarImageView.image = UIImage(named: "morz")
        avatarImageView.dropShadow()
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.clipsToBounds = true
        outerImageView.addSubview(avatarImageView)
    }

    private func setupOuterView() {
        let view = UIView()
        outerImageView = view
        outerImageView.clipsToBounds = false
        outerImageView.dropShadow()
        outerImageView.backgroundColor = GlobalColors.darkColor
        outerImageView.isUserInteractionEnabled = true
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
        avatarImageView.addSubview(imageButton)
    }

    private func setupImagePicker() {
        pickerController.delegate = self
        pickerController.allowsEditing = true
    }

    private func setupFullNameLabel() {
        let lbl = UILabel()
        fullNameLabel = lbl
        fullNameLabel.textColor = GlobalColors.darkColor
        fullNameLabel.textAlignment = .center
        fullNameLabel.font = UIFont(name: "DMSans-Bold", size: 15)
        self.view.addSubview(fullNameLabel)
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
            .height(titleLabel.frame.height * 0.89)
            .width(5%)
            .before(of: titleLabel, aligned: .top)
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
        avatarImageView.image = avatarImageView.image?.alpha(0.3)
        outerImageView.layer.cornerRadius = avatarImageView.frame.height / 2

        imageButton.pin.all()
        let width = imageButton.frame.width * 0.35
        let height = imageButton.frame.height * 0.35
        imageButton.imageEdgeInsets = UIEdgeInsets(top: height,
                                                   left: width,
                                                   bottom: height,
                                                   right: width)
    }

    private func setupFullNameLayout() {
        fullNameLabel.pin
            .below(of: outerImageView, aligned: .center)
            .marginTop(3.3%)
            .width(95%)
            .height(15)
    }

    private func setupTableViewLayout() {
        tableView.pin
            .top(39.77%)
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
    func setUserName(name: String?) {
        if let name = name {
            fullNameLabel.text = name
        }
    }

    func setUserImage(with imageUrl: URL?) {
        avatarImageView.kf.setImage(with: imageUrl)
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
        let height = screenBounds.height * 0.0881
        return height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SettingsSections(rawValue: indexPath.row) {
        case .myInvites:
            output?.didmyInvitesButtonTap()
        case .changeName:
            output?.didChangeNameTapped()
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
            output?.didImageLoaded(imageData: img.jpegData(compressionQuality: 0.1))
//            imageButton.imageEdgeInsets = UIEdgeInsets()
//            avatarImageView.image = img
//            imageButton.contentMode = .scaleToFill
//            imageButton.clipsToBounds = true
//            setupAvatarViewLayout()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            pickerController(picker, didSelect: nil)
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let image = info[.editedImage] as? UIImage else {
                pickerController(picker, didSelect: nil)
                return
            }
            pickerController(picker, didSelect: image)
        }
}
