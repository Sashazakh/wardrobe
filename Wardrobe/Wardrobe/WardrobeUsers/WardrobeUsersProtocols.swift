import Foundation

protocol WardrobeUsersViewInput: class {
    func reloadCollectionView()
    func changeEditButton(state: EditButtonState)
}

protocol WardrobeUsersViewOutput: class {
    func didEditButtonTap()
    func isEditButtonTapped() -> Bool
    func didInivteUserButtonTapped()
}

protocol WardrobeUsersInteractorInput: class {
}

protocol WardrobeUsersInteractorOutput: class {
}

protocol WardrobeUsersRouterInput: class {
    func showInviteUser(with wardrobeId: Int)
}
