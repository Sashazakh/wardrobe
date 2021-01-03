import Foundation

final class EditLookPresenter {
	weak var view: EditLookViewInput?

	private let router: EditLookRouterInput
	private let interactor: EditLookInteractorInput

    init(router: EditLookRouterInput, interactor: EditLookInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EditLookPresenter: EditLookViewOutput {
}

extension EditLookPresenter: EditLookInteractorOutput {
}
