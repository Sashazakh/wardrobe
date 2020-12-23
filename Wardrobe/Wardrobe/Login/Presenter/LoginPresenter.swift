import Foundation

final class LoginPresenter {
	weak var view: LoginViewInput?

	private let router: LoginRouterInput

	private let interactor: LoginInteractorInput

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
            return
        }

        guard let password = (userCredentials["password"] ?? ""),
              !password.isEmpty else {
            return
        }

        interactor.login(login: login, password: password)
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func userSuccesfullyLogin() {
        router.showWardrobeScreen()
    }

    func showAlert(title: String, message: String) {

    }
}

extension LoginPresenter {
    struct LoginData {
        var userName: String

        var imageURL: String?
    }
}
