import Foundation

final class LookPresenter {
	weak var view: LookViewInput?

	private let router: LookRouterInput
	private let interactor: LookInteractorInput

    init(router: LookRouterInput, interactor: LookInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LookPresenter: LookViewOutput {
}

extension LookPresenter: LookInteractorOutput {
}
