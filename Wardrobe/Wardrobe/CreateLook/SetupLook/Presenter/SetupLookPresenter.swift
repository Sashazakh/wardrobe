import Foundation

final class SetupLookPresenter {
	weak var view: SetupLookViewInput?

	private let router: SetupLookRouterInput
	private let interactor: SetupLookInteractorInput

    init(router: SetupLookRouterInput, interactor: SetupLookInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SetupLookPresenter: SetupLookViewOutput {
    func didTapBackToCreateWardrobeButton() {
        router.backToCreateLookScreen()
    }

    func didTapAddLookPhotoButton() {

    }
}

extension SetupLookPresenter: SetupLookInteractorOutput {
}
