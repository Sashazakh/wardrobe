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

    func showWardrobeScreen() {
        let lookVC = LookContainer.assemble(with: LookContext()).viewController

        lookVC.modalPresentationStyle = .fullScreen
        viewController?.present(lookVC, animated: true, completion: nil)
    }
}
