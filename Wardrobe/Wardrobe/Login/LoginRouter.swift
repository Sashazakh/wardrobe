import UIKit

final class LoginRouter {
   weak var viewController: UIViewController?
}

extension LoginRouter: LoginRouterInput {
    func showRegistrationScreen() {
        let registerVC = RegisterContainer.assemble(with: RegisterContext()).viewController

        registerVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.setViewControllers([registerVC], animated: true)
    }
}
