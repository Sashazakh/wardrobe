import Foundation

final class CreateLookPresenter {
    weak var view: CreateLookViewInput?

    private let router: CreateLookRouterInput

    private let interactor: CreateLookInteractorInput

    private var isEditing: Bool = false

    init(router: CreateLookRouterInput, interactor: CreateLookInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CreateLookPresenter: CreateLookViewOutput {
    func didTapBackToWardrobeDetailButton() {
        router.showWardrobeDetailScreen()
    }

    func didTapConfirmButton() {
        router.showSetupLookScreen()
    }
}

extension CreateLookPresenter: CreateLookInteractorOutput {
}
