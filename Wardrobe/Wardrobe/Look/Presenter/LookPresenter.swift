import Foundation

final class LookPresenter {
	weak var view: LookViewInput?

	private let router: LookRouterInput

	private let interactor: LookInteractorInput

    private var isEditing: Bool = false

    init(router: LookRouterInput, interactor: LookInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LookPresenter: LookViewOutput {
    func didTapEditLookButton() {
        isEditing ? view?.hideEditLayout() : view?.showEditLayout()
        isEditing = !isEditing
        view?.setLookIsEditing(isEditing: isEditing)
    }

    func didTapBackToWardrobeButton() {
        router.showWardrobeScreen()
    }
}

extension LookPresenter: LookInteractorOutput {
}
