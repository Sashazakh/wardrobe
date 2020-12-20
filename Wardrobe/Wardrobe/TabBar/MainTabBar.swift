import UIKit

class MainTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        prepareViewControllers()
    }

    private func setupTabBar() {
        tabBar.barTintColor = GlobalColors.tintColor
        tabBar.tintColor = GlobalColors.darkColor
        tabBar.unselectedItemTintColor = GlobalColors.darkColor
    }

    private func prepareViewControllers() {
        viewControllers = [prepareWardrobeScreen(),
                           prepareAllClothesScreen()]
    }

    private func prepareWardrobeScreen() -> UINavigationController {
        let container = MainScreenContainer.assemble(with: MainScreenContext())
        let tabBarItem = UITabBarItem(title: Constants.HomeBarItem.title,
                                      image: Constants.HomeBarItem.image,
                                      tag: Constants.HomeBarItem.tag)

        container.viewController.tabBarItem = tabBarItem

        let navigationVC = UINavigationController(rootViewController: container.viewController)

        navigationVC.navigationBar.isHidden = true

        return navigationVC
    }

    private func prepareAllClothesScreen() -> UINavigationController {
        let container = AllClothesContainer.assemble(with: AllClothesContext())
        let tabBarItem = UITabBarItem(title: Constants.AllClothesBarItem.title,
                                      image: Constants.AllClothesBarItem.image,
                                      tag: Constants.AllClothesBarItem.tag)

        container.viewController.tabBarItem = tabBarItem

        let navigationVC = UINavigationController(rootViewController: container.viewController)

        navigationVC.navigationBar.isHidden = true

        return navigationVC
    }

}

extension MainTabBar {
    private struct Constants {
        struct HomeBarItem {
            static let title: String = "Домой"
            static let image = UIImage(systemName: "house.fill")
            static let tag: Int = 0
        }

        struct AllClothesBarItem {
            static let title: String = "Мои вещи"
            static let image = UIImage(systemName: "ladybug.fill")
            static let tag: Int = 1
        }

    }
}
