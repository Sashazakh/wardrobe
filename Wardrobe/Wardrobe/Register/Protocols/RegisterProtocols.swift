import Foundation

protocol RegisterViewInput: AnyObject {
    func showPickPhotoAlert()

    func setUserImage(imageData: Data)

    func getNewUserCredentials() -> [String: String?]

    func getUserImage() -> Data?

    func showAlert(title: String, message: String)
}

protocol RegisterViewOutput: AnyObject {
    func didTapLoginLabel()

    func didTapAddPhotoButton()

    func didTapRegisterButton()

    func userDidSetImage(imageData: Data?)
}

protocol RegisterInteractorInput: AnyObject {
    func register(login: String,
                  fio: String,
                  password: String,
                  imageData: Data?)
}

protocol RegisterInteractorOutput: AnyObject {
    func showAlert(title: String, message: String)

    func userSuccesfullyRegistered()

    func updateModel(model: RegisterData)
}

protocol RegisterRouterInput: AnyObject {
    func showLoginScreen()

    func showWardrobeScreen(model: RegisterData)
}
