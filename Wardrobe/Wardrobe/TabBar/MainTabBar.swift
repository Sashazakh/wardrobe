import UIKit

class MainTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    private func setupTabBar() {
        tabBar.barTintColor = GlobalColors.tintColor
        tabBar.tintColor = #colorLiteral(red: 0.2705882353, green: 0.4117647059, blue: 0.5647058824, alpha: 1)
        tabBar.unselectedItemTintColor = GlobalColors.darkColor
    }
}
