import Foundation

protocol SetupLookViewInput: AnyObject {
    func showPickPhotoAlert()

    func setLookImage(imageData: Data)

    func getLookName() -> String?

    func getLookImage() -> Data?

    func showAlert(title: String, message: String)

    func disableSetupButtonInteraction()

    func enableSetupButtonInteraction()

    func disableKeyboard()
}

protocol SetupLookViewOutput: AnyObject {
    func didTapBackToCreateWardrobeButton()

    func didTapAddLookPhotoButton()

    func didTapSetupLookButton()

    func userDidSetImage(imageData: Data?)

    func didTapView()
}

protocol SetupLookInteractorInput: AnyObject {
    func createLook(name: String, imageData: Data?)
}

protocol SetupLookInteractorOutput: AnyObject {
    func lookDidSaved()

    func showAlert(title: String, message: String)
}

protocol SetupLookRouterInput: AnyObject {
    func backToCreateLookScreen()

    func backToWardrobeScreen()
}
