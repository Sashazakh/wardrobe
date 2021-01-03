import UIKit

final class LookRouter {
    weak var viewController: UIViewController?
}

extension LookRouter: LookRouterInput {
    func showWardrobeScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func showAllItemsScreen(lookID: Int) {
        let allItemsVC = AllItemsContainer.assemble(with: AllItemsContext(lookID: lookID)).viewController

        allItemsVC.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(allItemsVC, animated: true)
    }
}
