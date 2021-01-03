import UIKit

final class AllItemsRouter {
    weak var viewController: UIViewController?
}

extension AllItemsRouter: AllItemsRouterInput {
    func showLookScreen(items: [ItemData]) {
        guard let viewControllers = viewController?.navigationController?.viewControllers,
              let lookVC = viewControllers[viewControllers.count - 2] as? LookViewController else {
            return
        }

        lookVC.output?.didUserAddItems(items: items)

        viewController?.navigationController?.popViewController(animated: true)
    }

    func showLookScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
