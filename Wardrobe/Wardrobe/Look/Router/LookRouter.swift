import UIKit

final class LookRouter {
    weak var viewController: UIViewController?
}

extension LookRouter: LookRouterInput {
    func showWardrobeScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
