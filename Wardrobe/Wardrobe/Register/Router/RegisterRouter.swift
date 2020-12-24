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

    func showWardrobeScreen() {
        let tabBarVC = MainTabBar()

        tabBarVC.modalPresentationStyle = .fullScreen

        guard let sceneDelegate = viewController?.view.window?.windowScene?.delegate as? SceneDelegate else {
            return
        }

        sceneDelegate.setRootViewController(controller: tabBarVC)
    }
}
