import UIKit

final class AllClothesRouter {
    weak var viewController: UIViewController?
}

extension AllClothesRouter: AllClothesRouterInput {
    func showEditItemScreen() {
        let editItemVC = NewItemScreenContainer.assemble(with: NewItemScreenContext()).viewController

        editItemVC.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(editItemVC, animated: true)
    }
}
