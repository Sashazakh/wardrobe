import Foundation

final class WardrobeDetailPresenter {
	weak var view: WardrobeDetailViewInput?

	private let router: WardrobeDetailRouterInput
	private let interactor: WardrobeDetailInteractorInput

    var wardrobeId: Int?

    init(router: WardrobeDetailRouterInput, interactor: WardrobeDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension WardrobeDetailPresenter: WardrobeDetailViewOutput {
    func personDidTap() {
        guard let id = wardrobeId else { return }
        router.showPersons(with: id)
    }

    func didTapLook() {
        router.showLookScreen()
    }

    func didTapCreateLookCell() {
        router.showCreateLookScreen()
    }
}

extension WardrobeDetailPresenter: WardrobeDetailInteractorOutput {
}
