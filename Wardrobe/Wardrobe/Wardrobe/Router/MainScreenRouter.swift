import UIKit

final class MainScreenRouter {
    weak var viewController: MainScreenViewController?
}

extension MainScreenRouter: MainScreenRouterInput {
    func showDetailWardrope(id: Int) {
        let vc = WardrobeDetailContainer.assemble(with: WardrobeDetailContext()).viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func showSettings() {
        let vc = SettingsContainer.assemble(with: SettingsContext()).viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func showAddWardobeScreen() {
        let vc = CreateWardrobeContainer.assemble(with: CreateWardrobeContext()).viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
