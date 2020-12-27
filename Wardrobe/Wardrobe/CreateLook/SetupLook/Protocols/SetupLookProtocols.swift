import Foundation

protocol SetupLookViewInput: AnyObject {
}

protocol SetupLookViewOutput: AnyObject {
    func didTapBackToCreateWardrobeButton()

    func didTapAddLookPhotoButton()
}

protocol SetupLookInteractorInput: AnyObject {
}

protocol SetupLookInteractorOutput: AnyObject {
}

protocol SetupLookRouterInput: AnyObject {
    func backToCreateLookScreen()
}
