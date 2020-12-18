import UIKit
import PinLayout

final class RegisterViewController: UIViewController {
	var output: RegisterViewOutput?

    private weak var backgroundView: UIView!

    private weak var welcomeLabel: UILabel!

    private weak var loginTextField: UITextField!

    private weak var fioTextField: UITextField!

    private weak var passwordTextField: UITextField!

    private weak var repeatPasswordTextField: UITextField!

    private weak var addPhotoButton: UIButton!

    private weak var registeredQuestionLabel: UILabel!

    private weak var loginLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()

        setupView()
        setupSubviews()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutBackgroundView()
        layoutWelcomeLabel()
        layoutLoginTextField()
        layoutFioTextField()
        layoutPasswordTextField()
        layoutRepeatPasswordTextField()
        layoutAddPhotoButton()
        layoutRegisteredQuestionLabel()
        layoutLoginLabel()
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupSubviews() {
        setupBackgroundView()
        setupWelcomeLabel()
        setupLoginTextField()
        setupFioTextField()
        setupPasswordTextField()
        setupRepeatPasswordTextField()
        setupAddPhotoButton()
        setupRegisteredQuestionLabel()
        setupLoginLabel()
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
        let textField = UITextField()

        loginTextField = textField
        backgroundView.addSubview(loginTextField)

        loginTextField.attributedPlaceholder = NSAttributedString(string: "Логин (обязательно)",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        loginTextField.clipsToBounds = true
        loginTextField.layer.cornerRadius = 10
        loginTextField.layer.borderWidth = 1
        loginTextField.layer.borderColor = UIColor.white.cgColor
        loginTextField.backgroundColor = UIColor.white
        loginTextField.font = UIFont(name: "DMSans-Regular", size: 15)

        loginTextField.leftView = UIView(frame: CGRect(x: .zero,
                                                      y: .zero,
                                                      width: 10,
                                                      height: .zero))
        loginTextField.leftViewMode = .always
        loginTextField.rightView = UIView(frame: CGRect(x: .zero,
                                                       y: .zero,
                                                       width: 10,
                                                       height: .zero))
        loginTextField.rightViewMode = .unlessEditing

        loginTextField.clearButtonMode = .whileEditing
        loginTextField.autocorrectionType = .no
    }

    private func setupFioTextField() {
        let textField = UITextField()

        fioTextField = textField
        backgroundView.addSubview(fioTextField)

        fioTextField.attributedPlaceholder = NSAttributedString(string: "ФИО (обязательно)",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        fioTextField.clipsToBounds = true
        fioTextField.layer.cornerRadius = 10
        fioTextField.layer.borderWidth = 1
        fioTextField.layer.borderColor = UIColor.white.cgColor
        fioTextField.backgroundColor = UIColor.white
        fioTextField.font = UIFont(name: "DMSans-Regular", size: 15)

        fioTextField.leftView = UIView(frame: CGRect(x: .zero,
                                                      y: .zero,
                                                      width: 10,
                                                      height: .zero))
        fioTextField.leftViewMode = .always
        fioTextField.rightView = UIView(frame: CGRect(x: .zero,
                                                       y: .zero,
                                                       width: 10,
                                                       height: .zero))
        fioTextField.rightViewMode = .unlessEditing

        fioTextField.clearButtonMode = .whileEditing
        fioTextField.autocorrectionType = .no
    }

    private func setupPasswordTextField() {
        let textField = UITextField()

        passwordTextField = textField
        backgroundView.addSubview(passwordTextField)

        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль (обязательно)",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        passwordTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.font = UIFont(name: "DMSans-Regular", size: 15)

        passwordTextField.leftView = UIView(frame: CGRect(x: .zero,
                                                      y: .zero,
                                                      width: 10,
                                                      height: .zero))
        passwordTextField.leftViewMode = .always
        passwordTextField.rightView = UIView(frame: CGRect(x: .zero,
                                                       y: .zero,
                                                       width: 10,
                                                       height: .zero))
        passwordTextField.rightViewMode = .unlessEditing

        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
    }

    private func setupRepeatPasswordTextField() {
        let textField = UITextField()

        repeatPasswordTextField = textField
        backgroundView.addSubview(repeatPasswordTextField)

        repeatPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Повторите пароль (обязательно)",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        repeatPasswordTextField.clipsToBounds = true
        repeatPasswordTextField.layer.cornerRadius = 10
        repeatPasswordTextField.layer.borderWidth = 1
        repeatPasswordTextField.layer.borderColor = UIColor.white.cgColor
        repeatPasswordTextField.backgroundColor = UIColor.white
        repeatPasswordTextField.font = UIFont(name: "DMSans-Regular", size: 15)

        repeatPasswordTextField.leftView = UIView(frame: CGRect(x: .zero,
                                                      y: .zero,
                                                      width: 10,
                                                      height: .zero))
        repeatPasswordTextField.leftViewMode = .always
        repeatPasswordTextField.rightView = UIView(frame: CGRect(x: .zero,
                                                       y: .zero,
                                                       width: 10,
                                                       height: .zero))
        repeatPasswordTextField.rightViewMode = .unlessEditing

        repeatPasswordTextField.clearButtonMode = .whileEditing
        repeatPasswordTextField.autocorrectionType = .no
        repeatPasswordTextField.isSecureTextEntry = true
    }

    private func setupAddPhotoButton() {
        let button = UIButton()

        addPhotoButton = button
        view.addSubview(addPhotoButton)

        addPhotoButton.backgroundColor = .white
        addPhotoButton.layer.cornerRadius = 20

        addPhotoButton.titleLabel?.font = UIFont(name: "DMSans-Medium", size: 15)
        addPhotoButton.setTitleColor(.black, for: .normal)
        addPhotoButton.setTitle("Добавить фото", for: .normal)
    }

    private func setupRegisteredQuestionLabel() {
        let label = UILabel()

        registeredQuestionLabel = label
        view.addSubview(registeredQuestionLabel)

        registeredQuestionLabel.textAlignment = .right
        registeredQuestionLabel.text = "Уже зарегистрированы?"
        registeredQuestionLabel.font = UIFont(name: "DMSans-Regular", size: 12)
        registeredQuestionLabel.textColor = .gray
    }

    private func setupLoginLabel() {
        let label = UILabel()

        loginLabel = label
        view.addSubview(loginLabel)

        loginLabel.textAlignment = .left
        loginLabel.text = "Войти"
        loginLabel.font = UIFont(name: "DMSans-Regular", size: 12)
        loginLabel.textColor = .gray

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLoginLabel))

        recognizer.numberOfTapsRequired = 1
        label.addGestureRecognizer(recognizer)
        label.isUserInteractionEnabled = true
    }

    private func layoutBackgroundView() {
        backgroundView.pin
            .top(.zero)
            .width(100%)
            .height(Constants.screenHeight * 0.15 + 50 + 70 + 50 + 20 + 50 + 20 + 50 + 20 + 50 + 25 + 36 + 30)
    }

    private func layoutWelcomeLabel() {
        welcomeLabel.pin
            .top(Constants.screenHeight * 0.15)
            .hCenter()
            .width(80%)
            .height(50)
    }

    private func layoutLoginTextField() {
        loginTextField.pin
            .top(welcomeLabel.frame.maxY + 70)
            .hCenter()
            .width(90%)
            .height(50)
    }

    private func layoutFioTextField() {
        fioTextField.pin
            .top(loginTextField.frame.maxY + 20)
            .hCenter()
            .width(90%)
            .height(50)
    }

    private func layoutPasswordTextField() {
        passwordTextField.pin
            .top(fioTextField.frame.maxY + 20)
            .hCenter()
            .width(90%)
            .height(50)
    }

    private func layoutRepeatPasswordTextField() {
        repeatPasswordTextField.pin
            .top(passwordTextField.frame.maxY + 20)
            .hCenter()
            .width(90%)
            .height(50)
    }

    private func layoutAddPhotoButton() {
        addPhotoButton.pin
            .top(repeatPasswordTextField.frame.maxY + 25)
            .width(65%)
            .right(5%)
            .height(36)
    }

    private func layoutRegisteredQuestionLabel() {
        registeredQuestionLabel.pin
            .top(backgroundView.frame.maxY + 30)
            .left(.zero)
            .width(65%)
            .height(20)
    }

    private func layoutLoginLabel() {
        loginLabel.pin
            .sizeToFit()

        loginLabel.pin
            .top(backgroundView.frame.maxY + 30)
            .left(registeredQuestionLabel.frame.maxX + 5)
            .height(20)
    }

    @objc
    private func didTapLoginLabel() {
        output?.didTapLoginLabel()
    }
}

extension RegisterViewController: RegisterViewInput {
}

extension RegisterViewController {
    private struct Constants {
        static let screenHeight = UIScreen.main.bounds.height

        static let screenWidth = UIScreen.main.bounds.width

        struct WelcomeLabel {
            static let text: String = "Добро пожаловать!"
        }
    }
}
