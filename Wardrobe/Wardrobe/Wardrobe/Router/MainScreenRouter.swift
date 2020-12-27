import UIKit

final class MainScreenRouter {
    weak var viewController: MainScreenViewController?
}

extension MainScreenRouter: MainScreenRouterInput {
    func showDetailWardrope(id: Int) {
        let vc = WardrobeDetailContainer.assemble(with: WardrobeDetailContext()).viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func showSettings(login: String, name: String, imageUrl: String) {
        let vc = SettingsContainer.assemble(with: SettingsContext(login: login,
                                                                  name: name,
                                                                  imageUrl: imageUrl)).viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func showAddWardobeScreen(for user: String) {
        let vc = CreateWardrobeContainer.assemble(with: CreateWardrobeContext(login: user)).viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
