import UIKit

final class RegisterRouter {
    weak var viewController: UIViewController?
}

extension RegisterRouter: RegisterRouterInput {
    func showLoginScreen() {
        let loginVC = LoginContainer.assemble(with: LoginContext()).viewController

        loginVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.setViewControllers([loginVC], animated: true)
    }
}
