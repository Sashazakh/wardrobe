import UIKit

final class WardrobeDetailRouter {
    weak var viewController: UIViewController?
}

extension WardrobeDetailRouter: WardrobeDetailRouterInput {
    func showLookScreen(with lookId: Int) {
        let lookVC = LookContainer.assemble(with: LookContext(lookID: lookId)).viewController

        lookVC.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(lookVC, animated: true)
    }

    func showPersons(with wardrobeId: Int) {
        let vc = WardrobeUsersContainer.assemble(with:
                                                    WardrobeUsersContext(wardrobeId: wardrobeId)).viewController

        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func showCreateLookScreen() {
        let createLookVC = CreateLookContainer.assemble(with: CreateLookContext(wardrobeID: 1)).viewController

        createLookVC.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(createLookVC, animated: true)
    }
}
