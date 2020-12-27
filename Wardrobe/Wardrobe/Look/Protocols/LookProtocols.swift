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
}

protocol LookInteractorInput: AnyObject {
    func fetchLook()
}

protocol LookInteractorOutput: AnyObject {
    func lookDidReceived()

    func updateModel(model: LookData)

    func showAlert(title: String, message: String)
}

protocol LookRouterInput: AnyObject {
    func showWardrobeScreen()

    func showAllItemsScreen()
}
