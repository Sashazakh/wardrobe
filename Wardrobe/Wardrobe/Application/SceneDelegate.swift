import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else {
            return
        }

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = scene

        let initialVC = SplashScreenViewController()
        setRootViewController(controller: initialVC)
        window?.makeKeyAndVisible()
        authorize()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

extension SceneDelegate {
    func getInitalViewController(isAuthorized: Bool) -> UIViewController {
        if isAuthorized {
            guard let login = AuthService.shared.getUserLogin(),
                  let userName = AuthService.shared.getUserName() else {
                return UINavigationController(rootViewController: LoginContainer.assemble(with: LoginContext()).viewController)
            }

            let imageURL = AuthService.shared.getUserImageURL()

            let wardrobeContext = MainScreenContext(login: login,
                                                    userName: userName,
                                                    umageURL: imageURL)

            let allClothesContext = AllClothesContext(login: login,
                                                      userName: userName,
                                                      imageURL: imageURL)

            let tabBar = MainTabBarContainer.assemble(wardrobeContext: wardrobeContext,
                                                      allClothContext: allClothesContext).viewController

            tabBar.modalPresentationStyle = .fullScreen

            return tabBar
        } else {
            let loginViewController = LoginContainer.assemble(with: LoginContext()).viewController
            let navigationVC = UINavigationController(rootViewController: loginViewController)

            navigationVC.navigationBar.isHidden = true

            return navigationVC
        }
    }

    func setRootViewController(controller: UIViewController) {
        window?.rootViewController = controller
    }
}

extension SceneDelegate {
    func authorize() {
        AuthService.shared.isAuthorized { (result) in
            guard result.error == nil else {
                guard let networkError = result.error else {
                    return
                }

                let rootVC = self.getInitalViewController(isAuthorized: false)
                self.setRootViewController(controller: rootVC)

                guard let firstResponder = (rootVC as? UINavigationController)?.viewControllers.first as? LoginViewController else {
                    return
                }

                switch networkError {
                case .networkNotReachable:
                    firstResponder.showAlert(title: "Ошибка", message: "Не удается подключиться")
                case .userNotExist:
                    firstResponder.showAlert(title: "Ошибка", message: "Время сессии истекло")
                default:
                    firstResponder.showAlert(title: "Ошибка", message: "Мы скоро все починим")
                }

                return
            }

            guard let data = result.data else {
                return
            }

            self.setRootViewController(controller: self.getInitalViewController(isAuthorized: data))
        }
    }

    func logout() {
        authorize()
    }
}
