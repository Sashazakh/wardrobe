import UIKit

class MainTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    private func setupTabBar() {
        tabBar.barTintColor = GlobalColors.tintColor
        tabBar.tintColor = GlobalColors.darkColor
        tabBar.unselectedItemTintColor = GlobalColors.darkColor
    }
}
