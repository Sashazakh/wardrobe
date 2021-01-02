import Foundation

protocol AllClothesViewInput: class {
    func reloadData()
}

protocol AllClothesViewOutput: class {
    func didLoadView()
    func getCategoriesCount() -> Int
    func getTitle(for index: Int) -> String
    func getCategory(for index: Int) -> CategoryData?
    func didTapItem()
}

protocol AllClothesInteractorInput: class {
    func getAllClothes()
}

protocol AllClothesInteractorOutput: class {
    func showAlert(title: String, message: String)
    func handleModel(model: AllClothesModel)
}

protocol AllClothesRouterInput: class {
    func showAlert(title: String, message: String)
    func showEditItemScreen()
}
