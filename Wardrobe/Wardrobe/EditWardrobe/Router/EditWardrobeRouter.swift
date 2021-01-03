import UIKit

final class EditWardrobeRouter {
    weak var viewController: UIViewController?
}

extension EditWardrobeRouter: EditWardrobeRouterInput {
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
