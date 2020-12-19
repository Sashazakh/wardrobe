import Foundation

final class WardrobeDetailPresenter {
	weak var view: WardrobeDetailViewInput?

	private let router: WardrobeDetailRouterInput
	private let interactor: WardrobeDetailInteractorInput

    init(router: WardrobeDetailRouterInput, interactor: WardrobeDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension WardrobeDetailPresenter: WardrobeDetailViewOutput {
}

extension WardrobeDetailPresenter: WardrobeDetailInteractorOutput {
}
