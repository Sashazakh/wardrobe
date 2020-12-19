import Foundation

final class HandleLookPresenter {
	weak var view: HandleLookViewInput?

	private let router: HandleLookRouterInput
	private let interactor: HandleLookInteractorInput

    init(router: HandleLookRouterInput, interactor: HandleLookInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension HandleLookPresenter: HandleLookViewOutput {
}

extension HandleLookPresenter: HandleLookInteractorOutput {
}


