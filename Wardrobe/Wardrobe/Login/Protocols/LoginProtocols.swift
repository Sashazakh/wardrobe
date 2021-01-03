import Foundation

protocol LoginViewInput: AnyObject {
    func getUserCredentials() -> [String: String?]

    func disableKeyboard()

    func showAlert(title: String, message: String)
}

protocol LoginViewOutput: AnyObject {
    func didTapRegisterLabel()

    func didTapLoginButton()

    func didTapView()
}

protocol LoginInteractorInput: AnyObject {
    func login(login: String, password: String)
}

protocol LoginInteractorOutput: AnyObject {
    func updateModel(model: LoginData)

    func userSuccesfullyLogin()

    func showAlert(title: String, message: String)
}

protocol LoginRouterInput: AnyObject {
    func showRegistrationScreen()

    func showWardrobeScreen(model: LoginData)
}
