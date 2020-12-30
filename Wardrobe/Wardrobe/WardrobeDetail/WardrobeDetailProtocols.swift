import Foundation

protocol WardrobeDetailViewInput: class {
}

protocol WardrobeDetailViewOutput: class {
    func personDidTap()
    func didTapLook()
    func didTapCreateLookCell()
}

protocol WardrobeDetailInteractorInput: class {
}

protocol WardrobeDetailInteractorOutput: class {
}

protocol WardrobeDetailRouterInput: class {
    func showPersons(with wardrobeId: Int)
    func showLookScreen()
    func showCreateLookScreen()
}
