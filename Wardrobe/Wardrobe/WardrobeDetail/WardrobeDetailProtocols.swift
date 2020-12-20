import Foundation

protocol WardrobeDetailViewInput: class {
}

protocol WardrobeDetailViewOutput: class {
    func personDidTap()
}

protocol WardrobeDetailInteractorInput: class {
}

protocol WardrobeDetailInteractorOutput: class {
}

protocol WardrobeDetailRouterInput: class {
    func showPersons()
}
