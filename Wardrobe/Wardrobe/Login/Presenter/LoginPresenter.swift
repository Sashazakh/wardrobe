import Foundation

final class LoginPresenter {
	weak var view: LoginViewInput?

	private let router: LoginRouterInput

	private let interactor: LoginInteractorInput

    private var model: LoginData?

    init(router: LoginRouterInput, interactor: LoginInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginViewOutput {
    func didTapRegisterLabel() {
        router.showRegistrationScreen()
    }

    func didTapLoginButton() {
        guard let userCredentials = view?.getUserCredentials() else {
            return
        }

        guard let login = (userCredentials["login"] ?? ""),
              !login.isEmpty else {
            view?.showAlert(title: "Ошибка", message: "Введите Ваш логин")
            return
        }

        guard login.isValidString() else {
            let msg = "Возможны только строчные и заглавные буквы латинского алфавита (a-z, A-Z) и цифры от 0 до 9"
            self.showAlert(title: "Недопустимые символы в поле ввода пароля!", message: msg)
            return
        }

        guard let password = (userCredentials["password"] ?? ""),
              !password.isEmpty else {
            view?.showAlert(title: "Ошибка", message: "Введите Ваш пароль")
            return
        }

        guard password.isValidString() else {
            let msg = "Возможны только строчные и заглавные буквы латинского алфавита (a-z, A-Z) и цифры от 0 до 9"
            self.showAlert(title: "Недопустимые символы в поле ввода пароля!", message: msg)
            return
        }

        interactor.login(login: login, password: password)
    }

    func didTapView() {
        view?.disableKeyboard()
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func updateModel(model: LoginData) {
        self.model = model
    }

    func userSuccesfullyLogin() {
        guard let model = model else {
            return
        }

        router.showWardrobeScreen(model: model)
    }

    func showAlert(title: String, message: String) {
        view?.showAlert(title: title, message: message)
    }
}
