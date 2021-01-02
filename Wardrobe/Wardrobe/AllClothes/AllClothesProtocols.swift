import Foundation

protocol AllClothesViewInput: class {
}

protocol AllClothesViewOutput: class {
    func didTapItem()
}

protocol AllClothesInteractorInput: class {
}

protocol AllClothesInteractorOutput: class {
}

protocol AllClothesRouterInput: class {
    func showEditItemScreen()
}
