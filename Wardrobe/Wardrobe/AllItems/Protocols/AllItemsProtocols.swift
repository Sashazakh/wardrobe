import Foundation

protocol AllItemsViewInput: AnyObject {
    func showAlert(title: String, message: String)

    func showNoItemsLabel()

    func loadData()
}

protocol AllItemsViewOutput: AnyObject {
    func didTapConfirmButton()

    func didTapBackToLookButton()

    func didLoadView()

    func getRowsCount() -> Int

    func viewModel(index: Int) -> AllItemsTableViewCellViewModel

    func setSelection(categoryIndex: Int, itemIndex: Int)

    func didRefreshed(categoryIndex: Int, itemIndex: Int)

    func didRefreshRequested()
}

protocol AllItemsInteractorInput: AnyObject {
    func fetchUserItems()
}

protocol AllItemsInteractorOutput: AnyObject {
    func showAlert(title: String, message: String)

    func updateModel(model: AllItemsData)

    func userItemsDidReceived()
}

protocol AllItemsRouterInput: AnyObject {
    func showLookScreen(items: [ItemData])

    func showLookScreen()
}
