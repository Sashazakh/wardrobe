import Foundation

protocol CreateLookViewInput: AnyObject {
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

    func showSetupLookScreen()
}
