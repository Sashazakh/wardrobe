import Foundation

protocol WardrobeDetailViewInput: class {
}

protocol WardrobeDetailViewOutput: class {
    func didTapLook()
}

protocol WardrobeDetailInteractorInput: class {
}

protocol WardrobeDetailInteractorOutput: class {
}

protocol WardrobeDetailRouterInput: class {
    func showLookScreen()
}
