import Foundation

protocol WardrobeDetailViewInput: class {
}

protocol WardrobeDetailViewOutput: class {
    func personDidTap()
    func didTapLook()
}

protocol WardrobeDetailInteractorInput: class {
}

protocol WardrobeDetailInteractorOutput: class {
}

protocol WardrobeDetailRouterInput: class {
    func showPersons()
    func showLookScreen()
}
