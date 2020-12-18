import Foundation

protocol RegisterViewInput: AnyObject {
}

protocol RegisterViewOutput: AnyObject {
    func didTapLoginLabel()
}

protocol RegisterInteractorInput: AnyObject {
}

protocol RegisterInteractorOutput: AnyObject {
}

protocol RegisterRouterInput: AnyObject {
    func showLoginScreen()
}
