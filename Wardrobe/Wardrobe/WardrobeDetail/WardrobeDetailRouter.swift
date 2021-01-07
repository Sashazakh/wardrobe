import UIKit

final class WardrobeDetailRouter {
    weak var viewController: UIViewController?
}

extension WardrobeDetailRouter: WardrobeDetailRouterInput {
    func showEditLook(with lookId: Int) {
        let lookVc = EditLookContainer.assemble(with: EditLookContext(lookID: lookId)).viewController

        viewController?.navigationController?.pushViewController(lookVc, animated: true)
    }

    func showLookScreen(with lookId: Int, creatorLogin: String) {
        let lookVC = LookContainer.assemble(with: LookContext(lookID: lookId, ownerLogin: creatorLogin)).viewController

        lookVC.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(lookVC, animated: true)
    }

    func showPersons(wardrobeId: Int, wardrobeName: String) {
        let vc = WardrobeUsersContainer.assemble(with: WardrobeUsersContext(
                                                    wardrobeId: wardrobeId,
                                                    wardrobeName: wardrobeName)).viewController

        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func showCreateLookScreen(wardrobeId: Int, creatorLogin: String) {
        let createLookVC = CreateLookContainer.assemble(with: CreateLookContext(wardrobeID: wardrobeId, creatorLogin: creatorLogin)).viewController

        createLookVC.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(createLookVC, animated: true)
    }
}
