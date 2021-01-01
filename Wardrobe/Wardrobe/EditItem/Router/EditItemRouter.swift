import UIKit

final class EditItemRouter {
    weak var viewController: UIViewController?
}

extension EditItemRouter: EditItemRouterInput {
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
