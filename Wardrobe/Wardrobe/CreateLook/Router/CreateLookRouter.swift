import UIKit

final class CreateLookRouter {
    weak var viewController: UIViewController?
}

extension CreateLookRouter: CreateLookRouterInput {
    func showWardrobeDetailScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func showSetupLookScreen() {
        let setupLookVC = SetupLookContainer.assemble(with: SetupLookContext()).viewController

        viewController?.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(setupLookVC, animated: true)
    }
}
