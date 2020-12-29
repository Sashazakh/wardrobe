import UIKit

final class SetupLookRouter {
    weak var viewController: UIViewController?
}

extension SetupLookRouter: SetupLookRouterInput {
    func backToCreateLookScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func backToWardrobeScreen() {
        guard let viewControllers = viewController?.navigationController?.viewControllers else {
            return
        }

        viewController?.navigationController?.popToViewController(viewControllers[viewControllers.count - 3],
                                                                  animated: true)
    }
}
