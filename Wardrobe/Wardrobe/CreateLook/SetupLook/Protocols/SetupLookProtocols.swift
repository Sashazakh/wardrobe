import Foundation

protocol SetupLookViewInput: AnyObject {
    func showPickPhotoAlert()

    func setLookImage(imageData: Data)
}

protocol SetupLookViewOutput: AnyObject {
    func didTapBackToCreateWardrobeButton()

    func didTapAddLookPhotoButton()

    func userDidSetImage(imageData: Data?)
}

protocol SetupLookInteractorInput: AnyObject {
}

protocol SetupLookInteractorOutput: AnyObject {
}

protocol SetupLookRouterInput: AnyObject {
    func backToCreateLookScreen()
}
