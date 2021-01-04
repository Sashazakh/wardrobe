import Foundation

protocol AllClothesViewInput: class {
    func reloadData()
    func toggleEditMode()
}

protocol AllClothesViewOutput: class {
    func didLoadView()
    func getCategoriesCount() -> Int
    func getTitle(for index: Int) -> String
    func getCategory(for index: Int) -> CategoryData?
    func didTapItem(itemId: Int)
    func didTapAddItem(category: String)
    func didTapEditButton()
    func deleteItem(id: Int, collectionIndex: Int, cellIndex: Int)
}

protocol AllClothesInteractorInput: class {
    func getAllClothes()
    func deleteItem(id: Int, collectionIndex: Int, cellIndex: Int)
}

protocol AllClothesInteractorOutput: class {
    func showAlert(title: String, message: String)
    func handleModel(model: AllClothesModel)
    func didDeletedItem(collectionIndex: Int, cellIndex: Int)
}

protocol AllClothesRouterInput: class {
    func showAlert(title: String, message: String)
    func showEditItemScreen(itemId: Int)
    func showAddItemScreen(category: String)
}
