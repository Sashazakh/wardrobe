import UIKit

final class WardrobeDetailRouter {
    weak var viewController: UIViewController?
}

extension WardrobeDetailRouter: WardrobeDetailRouterInput {
    func showPersons() {
        let vc = WardrobeUsersContainer.assemble(with: WardrobeUsersContext()).viewController

        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

}
