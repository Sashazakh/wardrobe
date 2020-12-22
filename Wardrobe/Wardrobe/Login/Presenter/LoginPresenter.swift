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
        router.showWardrobeScreen()
    }
}

extension LoginPresenter: LoginInteractorOutput {
}
