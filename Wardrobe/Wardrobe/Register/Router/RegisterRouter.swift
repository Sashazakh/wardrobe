import UIKit
import SafariServices

final class RegisterRouter {
    weak var viewController: UIViewController?
}

extension RegisterRouter: RegisterRouterInput {
    func showTermsAndConditions() {
        guard let url = URL(string: DataService.shared.getBaseURL() + "/terms") else { return }
        if UIApplication.shared.canOpenURL(url) {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.modalPresentationStyle = .pageSheet
            safariViewController.dismissButtonStyle = .done
            self.viewController?.present(safariViewController, animated: true, completion: nil)
        }
    }

    func showLoginScreen() {
        let loginVC = LoginContainer.assemble(with: LoginContext()).viewController

        loginVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.setViewControllers([loginVC], animated: true)
    }

    func showWardrobeScreen(model: RegisterData) {
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
