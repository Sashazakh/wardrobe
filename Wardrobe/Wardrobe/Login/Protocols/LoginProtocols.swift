import Foundation

protocol LoginViewInput: AnyObject {
    func getUserCredentials() -> [String: String?]
}

protocol LoginViewOutput: AnyObject {
    func didTapRegisterLabel()

    func didTapLoginButton()
}

protocol LoginInteractorInput: AnyObject {
    func login(login: String, password: String)
}

protocol LoginInteractorOutput: AnyObject {
    func userSuccesfullyLogin()
}

protocol LoginRouterInput: AnyObject {
    func showRegistrationScreen()

    func showWardrobeScreen()
}
