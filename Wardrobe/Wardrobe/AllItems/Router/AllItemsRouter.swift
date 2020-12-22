import UIKit

final class AllItemsRouter {
    weak var viewController: UIViewController?
}

extension AllItemsRouter: AllItemsRouterInput {
    func showLookScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
