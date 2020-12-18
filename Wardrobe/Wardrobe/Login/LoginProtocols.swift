import Foundation

protocol LoginViewInput: AnyObject {
}

protocol LoginViewOutput: AnyObject {
    func didTapRegisterLabel()
}

protocol LoginInteractorInput: AnyObject {
}

protocol LoginInteractorOutput: AnyObject {
}

protocol LoginRouterInput: AnyObject {
    func showRegistrationScreen()
}
