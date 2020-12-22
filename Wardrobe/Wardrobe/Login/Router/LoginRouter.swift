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
        let tabBarVC = MainTabBar()

        tabBarVC.modalPresentationStyle = .fullScreen

        guard let sceneDelegate = viewController?.view.window?.windowScene?.delegate as? SceneDelegate else {
            return
        }

        sceneDelegate.setRootViewController(controller: tabBarVC)
    }
}
