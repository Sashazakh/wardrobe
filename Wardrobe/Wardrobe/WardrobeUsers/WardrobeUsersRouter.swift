import UIKit

final class WardrobeUsersRouter {
    weak var viewController: UIViewController?
}

extension WardrobeUsersRouter: WardrobeUsersRouterInput {
    func showInviteUser() {
        let vc = InviteContainer.assemble(with: InviteContext()).viewController

        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

}
