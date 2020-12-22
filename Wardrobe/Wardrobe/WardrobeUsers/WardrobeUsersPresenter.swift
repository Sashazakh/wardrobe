import Foundation

final class WardrobeUsersPresenter {
	weak var view: WardrobeUsersViewInput?

	private let router: WardrobeUsersRouterInput
	private let interactor: WardrobeUsersInteractorInput

    private var isUserEditButtonTapped: Bool = false

    init(router: WardrobeUsersRouterInput, interactor: WardrobeUsersInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension WardrobeUsersPresenter: WardrobeUsersViewOutput {
    func didEditButtonTap() {
        isUserEditButtonTapped = !isUserEditButtonTapped
        view?.reloadCollectionView()
        if isEditButtonTapped() {
            view?.changeEditButton(state: .accept)
        } else {
            view?.changeEditButton(state: .edit)
        }
    }

    func isEditButtonTapped() -> Bool {
        return isUserEditButtonTapped
    }
}

extension WardrobeUsersPresenter: WardrobeUsersInteractorOutput {
}
