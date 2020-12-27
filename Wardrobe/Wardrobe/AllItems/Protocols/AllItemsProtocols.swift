import Foundation

protocol AllItemsViewInput: AnyObject {
    func showEditLayout()

    func hideEditLayout()

    func showAlert(title: String, message: String)

    func loadData()
}

protocol AllItemsViewOutput: AnyObject {
    func didTapConfirmButton()

    func didTapBackToLookButton()

    func didLoadView()

    func getRowsCount() -> Int

    func viewModel(index: Int) -> AllItemsTableViewCellViewModel
}

protocol AllItemsInteractorInput: AnyObject {
    func fetchAllItems()
}

protocol AllItemsInteractorOutput: AnyObject {
    func showAlert(title: String, message: String)

    func updateModel(model: AllItemsData)

    func allItemsDidReceived()
}

protocol AllItemsRouterInput: AnyObject {
    func showLookScreen()
}
