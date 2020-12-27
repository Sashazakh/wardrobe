import UIKit

final class SetupLookRouter {
    weak var viewController: UIViewController?
}

extension SetupLookRouter: SetupLookRouterInput {
    func backToCreateLookScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
