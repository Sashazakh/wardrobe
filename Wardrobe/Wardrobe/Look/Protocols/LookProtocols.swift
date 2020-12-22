import Foundation

protocol LookViewInput: AnyObject {
    func showEditLayout()
    func hideEditLayout()
    func setLookIsEditing(isEditing: Bool)
}

protocol LookViewOutput: AnyObject {
    func didTapEditLookButton()
}

protocol LookInteractorInput: AnyObject {
}

protocol LookInteractorOutput: AnyObject {
}

protocol LookRouterInput: AnyObject {
}
