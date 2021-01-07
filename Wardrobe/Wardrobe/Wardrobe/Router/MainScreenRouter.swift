import UIKit

final class MainScreenRouter {
    weak var viewController: MainScreenViewController?
}

extension MainScreenRouter: MainScreenRouterInput {
    func showEditWardrobe(with wardrobeId: Int) {
        let lookVc = EditWardrobeContainer.assemble(with: EditWardrobeContext(wardrobeID: wardrobeId)).viewController

        viewController?.navigationController?.pushViewController(lookVc, animated: true)
    }

    func showDetailWardrope(id: Int, name: String, creatorLogin: String) {
        let vc = WardrobeDetailContainer.assemble(with: WardrobeDetailContext(
                                                    wardrobeId: id,
                                                    wardrobeName: name,
                                                    creatorLogin: creatorLogin)).viewController
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
