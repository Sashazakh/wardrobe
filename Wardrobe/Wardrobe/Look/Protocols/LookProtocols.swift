import Foundation

protocol LookViewInput: AnyObject {
    func showEditLayout()

    func hideEditLayout()

    func setLookIsEditing(isEditing: Bool)

    func loadData()

    func showAlert(title: String, message: String)

    func setLookTitle(with: String)
}

protocol LookViewOutput: AnyObject {
    func didTapEditLookButton()

    func didTapBackToWardrobeButton()

    func didTapAddItemsButton()

    func didLoadView()

    func getRowsCount() -> Int

    func viewModel(index: Int) -> LookTableViewCellViewModel

    func deleteViewModel(tableCellIndex: Int, collectionCellIndex: Int)

    func didUserAddItems(items: [ItemData])
}

protocol LookInteractorInput: AnyObject {
    func fetchLook()

    func getLookID() -> Int

    func appendItemsToLook(items: [ItemData])

    func deleteItems(categoryIndex: Int, itemIndex: Int)
}

protocol LookInteractorOutput: AnyObject {
    func lookDidReceived()

    func updateModel(model: LookData)

    func showAlert(title: String, message: String)
}

protocol LookRouterInput: AnyObject {
    func showWardrobeScreen()

    func showAllItemsScreen(lookID: Int)
}
