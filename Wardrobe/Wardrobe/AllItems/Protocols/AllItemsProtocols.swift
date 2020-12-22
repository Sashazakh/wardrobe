import Foundation

protocol AllItemsViewInput: AnyObject {
    func showEditLayout()

    func hideEditLayout()

    func setLookIsEditing(isEditing: Bool)
}

protocol AllItemsViewOutput: AnyObject {
    func didTapConfirmButton()

    func didTapBackToLookButton()
}

protocol AllItemsInteractorInput: AnyObject {
}

protocol AllItemsInteractorOutput: AnyObject {
}

protocol AllItemsRouterInput: AnyObject {
    func showLookScreen()
}
