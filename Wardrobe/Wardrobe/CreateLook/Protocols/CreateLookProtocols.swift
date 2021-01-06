import Foundation

protocol CreateLookViewInput: AnyObject {
    func showAlert(title: String, message: String)

    func loadData()

    func showNoItemsLabel()
}

protocol CreateLookViewOutput: AnyObject {
    func didLoadView()

    func didTapConfirmButton()

    func didTapBackToWardrobeDetailButton()

    func getRowsCount() -> Int

    func viewModel(index: Int) -> AllItemsTableViewCellViewModel

    func setSelection(categoryIndex: Int, itemIndex: Int, isSelected: Bool)

    func didRefreshCache(categoryIndex: Int, itemIndex: Int)

    func didRequestRefresh()
}

protocol CreateLookInteractorInput: AnyObject {
    func fetchAllItems()

    func getWardrobeID() -> Int
}

protocol CreateLookInteractorOutput: AnyObject {
    func updateModel(model: AllItemsData)

    func allItemsSuccesfullyReceived()

    func showAlert(title: String, message: String)
}

protocol CreateLookRouterInput: AnyObject {
    func showWardrobeDetailScreen()

    func showSetupLookScreen(wardrobeID: Int, itemsID: [Int])
}
