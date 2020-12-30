import Foundation

final class WardrobeUsersPresenter {
	weak var view: WardrobeUsersViewInput?

	private let router: WardrobeUsersRouterInput
	private let interactor: WardrobeUsersInteractorInput

    private var isUserEditButtonTapped: Bool = false

    var wardrobeId: Int?

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

    func didInivteUserButtonTapped() {
        guard let id = wardrobeId else { return }
        router.showInviteUser(with: id)
    }
}

extension WardrobeUsersPresenter: WardrobeUsersInteractorOutput {
}
