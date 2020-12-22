import Foundation

protocol LoginViewInput: AnyObject {
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
