import Foundation

protocol AllClothesViewInput: class {
    func reloadData()
    func toggleEditMode()
    func showDropMenu()
    func hideDropMenu()
}

protocol AllClothesViewOutput: class {
    func didLoadView()
    func getCategoriesCount() -> Int
    func getTitle(for index: Int) -> String
    func getCategory(for index: Int) -> CategoryData?
    func didTapItem(itemId: Int)
    func didTapAddItem(category: String)
    func didTapMoreMenuButton()
    func didTapEditButton()
    func didTapNewCategoryButton()
    func deleteItem(id: Int)
    func didRefreshRequested()
}

protocol AllClothesInteractorInput: class {
    func getAllClothes()
    func deleteItem(id: Int)
}

protocol AllClothesInteractorOutput: class {
    func showAlert(title: String, message: String)
    func handleModel(model: AllClothesModel)
    func didDeletedItem()
}

protocol AllClothesRouterInput: class {
    func showAlert(title: String, message: String)
    func showEditItemScreen(itemId: Int)
    func showAddItemScreen(category: String)
    func showNewCategoryAlert(complition: @escaping (String) -> Void)
}
