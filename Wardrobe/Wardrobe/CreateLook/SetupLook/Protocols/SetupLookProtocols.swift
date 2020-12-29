import Foundation

protocol SetupLookViewInput: AnyObject {
    func showPickPhotoAlert()

    func setLookImage(imageData: Data)

    func getLookName() -> String?

    func getLookImage() -> Data?

    func showAlert(title: String, message: String)
}

protocol SetupLookViewOutput: AnyObject {
    func didTapBackToCreateWardrobeButton()

    func didTapAddLookPhotoButton()

    func didTapSetupLookButton()

    func userDidSetImage(imageData: Data?)
}

protocol SetupLookInteractorInput: AnyObject {
    func createLook(name: String, imageData: Data?)
}

protocol SetupLookInteractorOutput: AnyObject {
}

protocol SetupLookRouterInput: AnyObject {
    func backToCreateLookScreen()
}
