import UIKit

final class WardrobeUsersRouter {
    weak var viewController: UIViewController?
}

extension WardrobeUsersRouter: WardrobeUsersRouterInput {
    func showInviteUser(with wardrobeId: Int) {
        if wardrobeId != -1 {
            let vc = InviteContainer.assemble(with: InviteContext(wardrobeId: wardrobeId)).viewController

            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
