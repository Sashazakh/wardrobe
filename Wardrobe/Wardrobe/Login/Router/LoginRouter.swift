import UIKit

final class LoginRouter {
   weak var viewController: UIViewController?
}

extension LoginRouter: LoginRouterInput {
    func showRegistrationScreen() {
        let registerVC = RegisterContainer.assemble(with: RegisterContext(termsAccepted: false)).viewController

        registerVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.setViewControllers([registerVC], animated: true)
    }

    func showWardrobeScreen(model: LoginData) {
        let wardrobeContext = MainScreenContext(login: model.login,
                                                umageURL: model.imageURL)

        let allClothesContext = AllClothesContext(login: model.login,
                                                  imageURL: model.imageURL)

        let tabBarVC = MainTabBarContainer.assemble(wardrobeContext: wardrobeContext,
                                                    allClothContext: allClothesContext).viewController

        tabBarVC.modalPresentationStyle = .fullScreen

        guard let sceneDelegate = viewController?.view.window?.windowScene?.delegate as? SceneDelegate else {
            return
        }

        sceneDelegate.setRootViewController(controller: tabBarVC)
    }
}
