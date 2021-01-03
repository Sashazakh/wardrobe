import Foundation

protocol RegisterViewInput: AnyObject {
    func showPickPhotoAlert()

    func setUserImage(imageData: Data)

    func getNewUserCredentials() -> [String: String?]

    func getUserImage() -> Data?

    func showAlert(title: String, message: String)

    func setCheckBoxChecked()

    func setCheckBoxUnchecked()

    func disableKeyboard()
}

protocol RegisterViewOutput: AnyObject {
    func didTapLoginLabel()

    func didTapAddPhotoButton()

    func didTapRegisterButton()

    func didTapCheckBox()

    func userDidSetImage(imageData: Data?)

    func didTapView()
}

protocol RegisterInteractorInput: AnyObject {
    func register(login: String,
                  fio: String,
                  password: String,
                  imageData: Data?)

    func toggleTermsState()

    func termsAreAccepted() -> Bool
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
