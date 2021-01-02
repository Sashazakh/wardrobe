import Foundation

final class AllClothesPresenter {
	weak var view: AllClothesViewInput?

	private let router: AllClothesRouterInput
	private let interactor: AllClothesInteractorInput

    init(router: AllClothesRouterInput, interactor: AllClothesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AllClothesPresenter: AllClothesViewOutput {
    func didTapItem() {
        router.showEditItemScreen()
    }
}

extension AllClothesPresenter: AllClothesInteractorOutput {
}
