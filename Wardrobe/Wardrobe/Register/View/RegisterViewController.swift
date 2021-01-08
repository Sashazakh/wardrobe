import UIKit
import PinLayout

final class RegisterViewController: UIViewController {
	var output: RegisterViewOutput?

    private weak var backgroundView: UIView!

    private weak var welcomeLabel: UILabel!

    private weak var loginTextField: UITextField!

    private weak var passwordTextField: UITextField!

    private weak var repeatPasswordTextField: UITextField!

    private weak var addPhotoButton: UIButton!

    private weak var userPhotoImageView: UIImageView!

    private weak var checkBoxImageView: UIImageView!

    private weak var conditionsLabel: UILabel!

    private weak var registerButton: UIButton!

    private weak var registeredQuestionLabel: UILabel!

    private weak var loginLabel: UILabel!

    private weak var underscoreView: UIView!

    private var imagePickerController: UIImagePickerController!

    private var keyboardOffset: CGFloat?

	override func viewDidLoad() {
		super.viewDidLoad()

        setupView()
        setupSubviews()
        setupKeyboardHandling()
        setupImagePicker()
	}

    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutBackgroundView()
        layoutWelcomeLabel()
        layoutLoginTextField()
        layoutPasswordTextField()
        layoutRepeatPasswordTextField()
        layoutAddPhotoButton()
        layoutUserPhotoImageView()
        layoutCheckBoxImageView()
        layoutConditionsLabel()
        layoutRegisterButton()
        layoutRegisteredQuestionLabel()
        layoutLoginLabel()
        layoutUnderscoreView()
    }

    private func setupView() {
        view.backgroundColor = .white

        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action: #selector(didTapView))

        tapRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapRecognizer)
    }

    private func setupImagePicker() {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
    }

    private func setupSubviews() {
        setupBackgroundView()
        setupWelcomeLabel()
        setupLoginTextField()
        setupPasswordTextField()
        setupRepeatPasswordTextField()
        setupAddPhotoButton()
        setupUserPhotoImageView()
        setupCheckBoxImageView()
        setupConditionsLabel()
        setupRegisterButton()
        setupRegisteredQuestionLabel()
        setupLoginLabel()
        setupUnderscoreView()
    }

    private func setupBackgroundView() {
        let subview = UIView()

        backgroundView = subview
        view.addSubview(backgroundView)

        backgroundView.backgroundColor = GlobalColors.mainBlueScreen
        backgroundView.dropShadow()
        backgroundView.roundLowerCorners(35)
    }

    private func setupWelcomeLabel() {
        let label = UILabel()

        welcomeLabel = label
        backgroundView.addSubview(welcomeLabel)

        welcomeLabel.font = UIFont(name: "DMSans-Bold", size: 30)
        welcomeLabel.textColor = .white
        welcomeLabel.textAlignment = .center
        welcomeLabel.text = Constants.WelcomeLabel.text
    }

    private func setupLoginTextField() {
        let textField = UITextField.customTextField(placeholder: "Имя пользователя")

        loginTextField = textField
        backgroundView.addSubview(loginTextField)
    }

    private func setupPasswordTextField() {
        let textField = UITextField.customTextField(placeholder: "Пароль")

        passwordTextField = textField
        backgroundView.addSubview(passwordTextField)

        passwordTextField.isSecureTextEntry = true
    }

    private func setupRepeatPasswordTextField() {
        let textField = UITextField.customTextField(placeholder: "Повторите пароль")

        repeatPasswordTextField = textField
        backgroundView.addSubview(repeatPasswordTextField)

        repeatPasswordTextField.isSecureTextEntry = true
    }

    private func setupAddPhotoButton() {
        let button = UIButton()

        addPhotoButton = button
        backgroundView.addSubview(addPhotoButton)

        addPhotoButton.backgroundColor = .white
        addPhotoButton.layer.cornerRadius = (8%.of(55%.of(Constants.screenHeight))) / 2

        addPhotoButton.titleLabel?.font = UIFont(name: "DMSans-Medium", size: 15)
        addPhotoButton.setTitleColor(GlobalColors.darkColor, for: .normal)
        addPhotoButton.setTitle("Выбрать фото", for: .normal)

        addPhotoButton.addTarget(self, action: #selector(didTapAddPhotoButton), for: .touchUpInside)
    }

    private func setupUserPhotoImageView() {
        let imageView = UIImageView()

        userPhotoImageView = imageView
        backgroundView.addSubview(userPhotoImageView)

        userPhotoImageView.layer.cornerRadius = 17%.of(Constants.screenWidth) / 2
        userPhotoImageView.backgroundColor = .white
        userPhotoImageView.image = UIImage(systemName: "camera.fill")
        userPhotoImageView.contentMode = .center
        userPhotoImageView.clipsToBounds = true
        userPhotoImageView.tintColor = .gray
    }

    private func setupCheckBoxImageView() {
        let imageView = UIImageView()

        checkBoxImageView = imageView
        view.addSubview(checkBoxImageView)

        checkBoxImageView.image = UIImage(named: "checkBoxNotChecked")

        let boxTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox))

        boxTapRecognizer.numberOfTapsRequired = 1
        checkBoxImageView.addGestureRecognizer(boxTapRecognizer)
        checkBoxImageView.isUserInteractionEnabled = true
    }

    private func setupConditionsLabel() {
        let label = UILabel()

        conditionsLabel = label
        view.addSubview(conditionsLabel)

        conditionsLabel.lineBreakMode = .byWordWrapping
        conditionsLabel.font = UIFont(name: "DMSans-Regular", size: 13)
        conditionsLabel.text = "Создавая учетную запись, вы соглашаетесь с правилами использования."
        conditionsLabel.textColor = GlobalColors.darkColor
        conditionsLabel.textAlignment = .left
        conditionsLabel.numberOfLines = .zero
    }

    private func setupRegisterButton() {
        let button = UIButton()

        registerButton = button
        view.addSubview(registerButton)

        registerButton.backgroundColor = GlobalColors.mainBlueScreen
        registerButton.layer.cornerRadius = 20
        registerButton.dropShadow()

        registerButton.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 17)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.setTitle("Зарегистироваться", for: .normal)

        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }

    private func setupRegisteredQuestionLabel() {
        let label = UILabel()

        registeredQuestionLabel = label
        view.addSubview(registeredQuestionLabel)

        registeredQuestionLabel.textAlignment = .right
        registeredQuestionLabel.text = "Уже зарегистрированы?"
        registeredQuestionLabel.font = UIFont(name: "DMSans-Regular", size: 12)
        registeredQuestionLabel.textColor = GlobalColors.darkColor
    }

    private func setupLoginLabel() {
        let label = UILabel()

        loginLabel = label
        view.addSubview(loginLabel)

        loginLabel.textAlignment = .left
        loginLabel.text = "Войти"
        loginLabel.font = UIFont(name: "DMSans-Regular", size: 12)
        loginLabel.textColor = GlobalColors.darkColor

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLoginLabel))

        recognizer.numberOfTapsRequired = 1
        label.addGestureRecognizer(recognizer)
        label.isUserInteractionEnabled = true
    }

    private func setupUnderscoreView() {
        let underscore = UIView()

        underscoreView = underscore
        view.addSubview(underscoreView)

        underscoreView.backgroundColor = GlobalColors.darkColor
    }

    private func layoutBackgroundView() {
        if let offset = keyboardOffset {
            backgroundView.pin
                .top(-offset)
                .width(100%)
                .height(55%.of(Constants.screenHeight) + 40)
        } else {
            backgroundView.pin
                .top(.zero)
                .width(100%)
                .height(55%.of(Constants.screenHeight) + 40)
        }
    }

    private func layoutWelcomeLabel() {
        welcomeLabel.pin
            .top(20%)
            .hCenter()
            .width(80%)
            .height(40)
    }

    private func layoutLoginTextField() {
        loginTextField.pin
            .below(of: welcomeLabel).marginTop(10%)
            .hCenter()
            .width(90%)
            .height(10%)
    }

    private func layoutPasswordTextField() {
        passwordTextField.pin
            .below(of: loginTextField).marginTop(3%)
            .hCenter()
            .width(90%)
            .height(10%)
    }

    private func layoutRepeatPasswordTextField() {
        repeatPasswordTextField.pin
            .below(of: passwordTextField).marginTop(3%)
            .hCenter()
            .width(90%)
            .height(10%)
    }

    private func layoutAddPhotoButton() {
        addPhotoButton.pin
            .below(of: repeatPasswordTextField).marginTop(8.5%)
            .width(65%)
            .right(5%)
            .height(8%)
    }

    private func layoutUserPhotoImageView() {
        userPhotoImageView.pin
            .height(17%.of(Constants.screenWidth))
            .width(17%.of(Constants.screenWidth))

        userPhotoImageView.pin
            .top(addPhotoButton.frame.midY - userPhotoImageView.bounds.height / 2)
            .left(5%)
    }

    private func layoutCheckBoxImageView() {
        checkBoxImageView.pin
            .height(6%.of(Constants.screenWidth))
            .width(6%.of(Constants.screenWidth))

        checkBoxImageView.pin
            .below(of: backgroundView).marginTop(3%)
            .left(5%)
    }

    private func layoutConditionsLabel() {
        conditionsLabel.pin
            .height(40)

        conditionsLabel.pin
            .top(checkBoxImageView.frame.midY - conditionsLabel.bounds.height / 2)
            .right(of: checkBoxImageView).marginLeft(5%)
            .right(5%)
    }

    private func layoutRegisterButton() {
        registerButton.pin
            .below(of: conditionsLabel).marginTop(2%)
            .width(90%)
            .hCenter()
            .height(6%)
    }

    private func layoutRegisteredQuestionLabel() {
        registeredQuestionLabel.pin
            .sizeToFit()

        registeredQuestionLabel.pin
            .below(of: registerButton).marginTop(1%)
            .left(.zero)
            .width(65%)
    }

    private func layoutLoginLabel() {
        loginLabel.pin
            .sizeToFit()

        loginLabel.pin
            .below(of: registerButton).marginTop(1%)
            .right(of: registeredQuestionLabel).marginLeft(1%)
    }

    private func layoutUnderscoreView() {
        underscoreView.pin
            .top(loginLabel.frame.maxY - 3)
            .height(1)
            .left(loginLabel.frame.minX)
            .right(Constants.screenWidth - loginLabel.frame.maxX)
    }

    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardFrame = keyboardSize.cgRectValue

        if Constants.screenHeight - keyboardFrame.height - 5 <= registerButton.frame.maxY {
            keyboardOffset = registerButton.frame.maxY - (Constants.screenHeight - keyboardFrame.height - 5)
        }

        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        keyboardOffset = nil

        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    @objc
    private func didTapLoginLabel() {
        output?.didTapLoginLabel()
    }

    @objc
    private func didTapCheckBox() {
        output?.didTapCheckBox()
    }

    @objc
    private func didTapRegisterButton() {
        output?.didTapRegisterButton()
    }

    @objc
    private func didTapAddPhotoButton() {
        output?.didTapAddPhotoButton()
    }

    @objc
    private func didTapView() {
        output?.didTapView()
    }
}

extension RegisterViewController: RegisterViewInput {
    func showPickPhotoAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = alertAction(type: .camera, title: "Камера") {
            alertController.addAction(action)
        }

        if let action = alertAction(type: .savedPhotosAlbum, title: "Галерея") {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alertController.modalPresentationStyle = .automatic
        present(alertController, animated: true, completion: nil)
    }

    func setUserImage(imageData: Data) {
        guard let image = UIImage(data: imageData) else {
            return
        }

        userPhotoImageView.contentMode = .scaleToFill
        userPhotoImageView.image = image
    }

    func getNewUserCredentials() -> [String: String?] {
        var credentials: [String: String?] = [:]

        credentials["login"] = loginTextField.text
        credentials["password"] = passwordTextField.text
        credentials["repeatPassword"] = repeatPasswordTextField.text

        return credentials
    }

    func getUserImage() -> Data? {
        return userPhotoImageView.image?.jpegData(compressionQuality: 1)
    }

    func setCheckBoxChecked() {
        checkBoxImageView.image = UIImage(named: "checkBoxChecked")
    }

    func setCheckBoxUnchecked() {
        checkBoxImageView.image = UIImage(named: "checkBoxNotChecked")
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)

        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }

    func disableKeyboard() {
        view.endEditing(true)
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func alertAction(type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            imagePickerController.sourceType = type
            present(self.imagePickerController, animated: true)
        }
    }

    private func imagePickerController(_ controller: UIImagePickerController, selectedImage: UIImage?) {
        controller.dismiss(animated: true, completion: nil)

        guard let image = selectedImage else {
            return
        }

        output?.userDidSetImage(imageData: image.jpegData(compressionQuality: Constants.UserPhotoImageView.compression))
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            imagePickerController(picker, selectedImage: nil)
            return
        }

        imagePickerController(picker, selectedImage: image)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController(picker, selectedImage: nil)
    }
}

extension RegisterViewController {
    private struct Constants {
        static let screenHeight = UIScreen.main.bounds.height

        static let screenWidth = UIScreen.main.bounds.width

        struct WelcomeLabel {
            static let text: String = "Регистрация"
        }

        struct UserPhotoImageView {
            static let compression: CGFloat = 0.1
        }
    }
}
