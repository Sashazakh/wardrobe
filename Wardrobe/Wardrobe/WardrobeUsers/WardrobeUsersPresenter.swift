import Foundation

final class WardrobeUsersPresenter {
	weak var view: WardrobeUsersViewInput?

	private let router: WardrobeUsersRouterInput
	private let interactor: WardrobeUsersInteractorInput

    init(router: WardrobeUsersRouterInput, interactor: WardrobeUsersInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension WardrobeUsersPresenter: WardrobeUsersViewOutput {
}

extension WardrobeUsersPresenter: WardrobeUsersInteractorOutput {
}
