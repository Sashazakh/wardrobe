import UIKit
import PinLayout

final class LoginViewController: UIViewController {
	var output: LoginViewOutput?

    private weak var backgroundView: UIView!

    private weak var welcomeLabel: UILabel!

    private weak var loginTextField: UITextField!

    private weak var passwordTextField: UITextField!

    private weak var loginButton: UIButton!

    private weak var accountQuestionLabel: UILabel!

    private weak var registerLabel: UILabel!

    private weak var underscoreView: UIView!

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
        layoutPasswordTextField()
        layoutLoginButton()
        layoutAccountQuestionLabel()
        layoutRegisterLabel()
        layoutUnderscoreView()
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupSubviews() {
        setupBackgroundView()
        setupWelcomeLabel()
        setupLoginTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupAccountQuestionLabel()
        setupRegisterLabel()
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
        let textField = UITextField()

        loginTextField = textField
        backgroundView.addSubview(loginTextField)

        loginTextField.attributedPlaceholder = NSAttributedString(string: "Логин",
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

    private func setupPasswordTextField() {
        let textField = UITextField()

        passwordTextField = textField
        backgroundView.addSubview(passwordTextField)

        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль",
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

    private func setupLoginButton() {
        let button = UIButton()

        loginButton = button
        view.addSubview(loginButton)

        loginButton.backgroundColor = GlobalColors.mainBlueScreen
        loginButton.layer.cornerRadius = 20
        loginButton.dropShadow()

        loginButton.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 17)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Войти", for: .normal)
    }

    private func setupAccountQuestionLabel() {
        let label = UILabel()

        accountQuestionLabel = label
        view.addSubview(accountQuestionLabel)

        accountQuestionLabel.textAlignment = .right
        accountQuestionLabel.text = "Еще нет аккаунта?"
        accountQuestionLabel.font = UIFont(name: "DMSans-Regular", size: 12)
        accountQuestionLabel.textColor = .gray
    }

    private func setupRegisterLabel() {
        let label = UILabel()

        registerLabel = label
        view.addSubview(registerLabel)

        registerLabel.textAlignment = .left
        registerLabel.text = "Зарегистрироваться"
        registerLabel.font = UIFont(name: "DMSans-Regular", size: 12)
        registerLabel.textColor = .gray

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTapRegisterLabel))

        recognizer.numberOfTapsRequired = 1
        label.addGestureRecognizer(recognizer)
        label.isUserInteractionEnabled = true
    }

    private func setupUnderscoreView() {
        let underscore = UIView()

        underscoreView = underscore
        view.addSubview(underscoreView)

        underscoreView.backgroundColor = .gray
    }

    private func layoutBackgroundView() {
        backgroundView.pin
            .top(.zero)
            .width(100%)
            .height(Constants.screenHeight * 0.15 + 50 + 70 + 50 + 20 + 50 + 20)
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

    private func layoutPasswordTextField() {
        passwordTextField.pin
            .top(loginTextField.frame.maxY + 20)
            .hCenter()
            .width(90%)
            .height(50)
    }

    private func layoutLoginButton() {
        loginButton.pin
            .top(backgroundView.frame.maxY + 30)
            .width(90%)
            .hCenter()
            .height(50)
    }

    private func layoutAccountQuestionLabel() {
        accountQuestionLabel.pin
            .top(loginButton.frame.maxY + 10)
            .width(49.5%)
            .left(.zero)
            .height(20)
    }

    private func layoutRegisterLabel() {
        registerLabel.pin
            .sizeToFit()

        registerLabel.pin
            .top(loginButton.frame.maxY + 10)
            .left(accountQuestionLabel.frame.maxX + 5)
            .height(20)
    }

    private func layoutUnderscoreView() {
        underscoreView.pin
            .top(registerLabel.frame.maxY - 3)
            .height(1)
            .left(registerLabel.frame.minX)
            .right(Constants.screenWidth - registerLabel.frame.maxX)
    }

    @objc
    private func didTapRegisterLabel() {
        output?.didTapRegisterLabel()
    }
}

extension LoginViewController: LoginViewInput {
}

extension LoginViewController {
    private struct Constants {
        static let screenHeight = UIScreen.main.bounds.height

        static let screenWidth = UIScreen.main.bounds.width

        struct WelcomeLabel {
            static let text: String = "Добро пожаловать!"
        }
    }
}
