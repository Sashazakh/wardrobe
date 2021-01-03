import Foundation

final class EditWardrobePresenter {
	weak var view: EditWardrobeViewInput?

	private let router: EditWardrobeRouterInput
	private let interactor: EditWardrobeInteractorInput

    init(router: EditWardrobeRouterInput, interactor: EditWardrobeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EditWardrobePresenter: EditWardrobeViewOutput {
}

extension EditWardrobePresenter: EditWardrobeInteractorOutput {
}
