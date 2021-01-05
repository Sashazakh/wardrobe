import UIKit

final class MainTabBarContainer {
    let viewController: UIViewController

    static func assemble(wardrobeContext: MainScreenContext,
                         allClothContext: AllClothesContext) -> MainTabBarContainer {
        let tabBarVC = MainTabBar()

         tabBarVC.viewControllers = [prepareWardrobeScreen(context: wardrobeContext),
                                     prepareAllClothesScreen(context: allClothContext)]

        return MainTabBarContainer(viewController: tabBarVC)
    }

    private static func prepareWardrobeScreen(context: MainScreenContext) -> UINavigationController {
        let container = MainScreenContainer.assemble(with: context)
        let tabBarItem = UITabBarItem(title: Constants.HomeBarItem.title,
                                      image: Constants.HomeBarItem.image,
                                      tag: Constants.HomeBarItem.tag)

        container.viewController.tabBarItem = tabBarItem

        let navigationVC = UINavigationController(rootViewController: container.viewController)

        navigationVC.navigationBar.isHidden = true

        return navigationVC
    }

    private static func prepareAllClothesScreen(context: AllClothesContext) -> UINavigationController {
        let container = AllClothesContainer.assemble(with: context)
        let tabBarItem = UITabBarItem(title: Constants.AllClothesBarItem.title,
                                      image: Constants.AllClothesBarItem.image,
                                      tag: Constants.AllClothesBarItem.tag)

        container.viewController.tabBarItem = tabBarItem

        let navigationVC = UINavigationController(rootViewController: container.viewController)

        navigationVC.navigationBar.isHidden = true

        return navigationVC
    }

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension MainTabBarContainer {
    private struct Constants {
        struct HomeBarItem {
            static let title: String = "Домой"
            static let image = UIImage(systemName: "house.fill")
            static let tag: Int = 0
        }

        struct AllClothesBarItem {
            static let title: String = "Мои вещи"
            static let image = UIImage(systemName: "cube.box.fill")
            static let tag: Int = 1
        }

    }
}
