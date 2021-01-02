import UIKit

final class AllClothesRouter {
    weak var viewController: UIViewController?
}

extension AllClothesRouter: AllClothesRouterInput {
    func showEditItemScreen() {
        let editItemVC = EditItemContainer.assemble(with: EditItemContext(itemID: 1)).viewController

        editItemVC.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(editItemVC, animated: true)
    }
}
