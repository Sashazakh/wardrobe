import UIKit

final class SettingsRouter {
    weak var viewController: UIViewController?
}

extension SettingsRouter: SettingsRouterInput {
    func showMyInvites() {
        let vc = MyInvitesContainer.assemble(with: MyInvitesContext()).viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
