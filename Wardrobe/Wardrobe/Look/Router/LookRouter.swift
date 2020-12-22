import UIKit

final class LookRouter {
    weak var viewController: UIViewController?
}

extension LookRouter: LookRouterInput {
    func showWardrobeScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func showAllItemsScreen() {
        let allItemsVC = AllItemsContainer.assemble(with: AllItemsContext()).viewController

        allItemsVC.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(allItemsVC, animated: true)
    }
}
