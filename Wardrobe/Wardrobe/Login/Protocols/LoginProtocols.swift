import Foundation

protocol LoginViewInput: AnyObject {
    func getUserCredentials()
}

protocol LoginViewOutput: AnyObject {
    func didTapRegisterLabel()

    func didTapLoginButton()
}

protocol LoginInteractorInput: AnyObject {
}

protocol LoginInteractorOutput: AnyObject {
}

protocol LoginRouterInput: AnyObject {
    func showRegistrationScreen()

    func showWardrobeScreen()
}
