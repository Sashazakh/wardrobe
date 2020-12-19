import Foundation

final class InvitePresenter {
	weak var view: InviteViewInput?

	private let router: InviteRouterInput
	private let interactor: InviteInteractorInput

    init(router: InviteRouterInput, interactor: InviteInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension InvitePresenter: InviteViewOutput {
}

extension InvitePresenter: InviteInteractorOutput {
}


