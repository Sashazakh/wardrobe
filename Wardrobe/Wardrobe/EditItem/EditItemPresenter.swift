import Foundation

final class EditItemPresenter {
	weak var view: EditItemViewInput?

	private let router: EditItemRouterInput
	private let interactor: EditItemInteractorInput

    init(router: EditItemRouterInput, interactor: EditItemInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EditItemPresenter: EditItemViewOutput {
}

extension EditItemPresenter: EditItemInteractorOutput {
}
