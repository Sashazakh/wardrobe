import Foundation

protocol WardrobeUsersViewInput: class {
    func reloadCollectionView()
    func changeEditButton(state: EditButtonState)
}

protocol WardrobeUsersViewOutput: class {
    func didEditButtonTap()
    func isEditButtonTapped() -> Bool
}

protocol WardrobeUsersInteractorInput: class {
}

protocol WardrobeUsersInteractorOutput: class {
}

protocol WardrobeUsersRouterInput: class {
}
