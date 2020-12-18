import UIKit
import PinLayout

final class RegisterViewController: UIViewController {
	var output: RegisterViewOutput?

    private weak var backgroundView: UIView!

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
        layoutRegisteredQuestionLabel()
        layoutLoginLabel()
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupSubviews() {
        setupBackgroundView()
        setupRegisteredQuestionLabel()
        setupLoginLabel()
    }

    private func setupBackgroundView() {
        let subview = UIView()

        backgroundView = subview
        view.addSubview(backgroundView)

        backgroundView.backgroundColor = GlobalColors.mainBlueScreen
        backgroundView.layer.cornerRadius = 35
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
            .height(70%)
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
