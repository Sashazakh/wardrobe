import Foundation

protocol LookViewInput: AnyObject {
    func showEditLayout()

    func hideEditLayout()

    func setLookIsEditing(isEditing: Bool)
}

protocol LookViewOutput: AnyObject {
    func didTapEditLookButton()

    func didTapBackToWardrobeButton()

    func didTapAddItemsButton()
}

protocol LookInteractorInput: AnyObject {
}

protocol LookInteractorOutput: AnyObject {
}

protocol LookRouterInput: AnyObject {
    func showWardrobeScreen()

    func showAllItemsScreen()
}
