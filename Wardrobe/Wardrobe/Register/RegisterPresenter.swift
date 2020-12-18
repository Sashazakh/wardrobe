import Foundation

final class RegisterPresenter {
	weak var view: RegisterViewInput?

	private let router: RegisterRouterInput
	private let interactor: RegisterInteractorInput

    init(router: RegisterRouterInput, interactor: RegisterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension RegisterPresenter: RegisterViewOutput {
    func didTapLoginLabel() {
        router.showLoginScreen()
    }
}

extension RegisterPresenter: RegisterInteractorOutput {
}
