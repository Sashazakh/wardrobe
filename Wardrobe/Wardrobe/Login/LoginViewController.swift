import UIKit
import PinLayout

final class LoginViewController: UIViewController {
	var output: LoginViewOutput?

    private weak var welcomeLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()

        setupView()
        setupSubviews()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutWelcomeLabel()
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupSubviews() {
        setupWelcomeLabel()
    }

    private func setupWelcomeLabel() {
        let label = UILabel()

        welcomeLabel = label
        view.addSubview(welcomeLabel)

        welcomeLabel.font = UIFont(name: "DMSans-Bold", size: 30)
        welcomeLabel.textColor = .black
        welcomeLabel.textAlignment = .center
        welcomeLabel.text = Constants.WelcomeLabel.text
    }

    private func layoutWelcomeLabel() {
        welcomeLabel.pin
            .top(15%)
            .hCenter()
            .width(80%)
            .sizeToFit()
    }
}

extension LoginViewController: LoginViewInput {
}

extension LoginViewController {
    private struct Constants {
        struct WelcomeLabel {
            static let text = "Добро пожаловать!"
        }
    }
}
