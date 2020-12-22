import Foundation

protocol CreateLookViewInput: AnyObject {
    func showSetupLookNameAlert()
}

protocol CreateLookViewOutput: AnyObject {
    func didTapConfirmButton()

    func didTapBackToWardrobeDetailButton()
}

protocol CreateLookInteractorInput: AnyObject {
}

protocol CreateLookInteractorOutput: AnyObject {
}

protocol CreateLookRouterInput: AnyObject {
    func showWardrobeDetailScreen()
}
