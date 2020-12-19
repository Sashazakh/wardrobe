import Foundation

protocol RegisterViewInput: AnyObject {
    func showPickPhotoAlert()

    func setUserImage(imageData: Data)
}

protocol RegisterViewOutput: AnyObject {
    func didTapLoginLabel()

    func didTapAddPhotoButton()

    func userDidSetImage(imageData: Data?)
}

protocol RegisterInteractorInput: AnyObject {
}

protocol RegisterInteractorOutput: AnyObject {
}

protocol RegisterRouterInput: AnyObject {
    func showLoginScreen()
}
