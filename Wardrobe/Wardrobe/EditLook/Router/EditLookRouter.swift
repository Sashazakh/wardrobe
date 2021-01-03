import UIKit

final class EditLookRouter {
    weak var viewController: UIViewController?
}

extension EditLookRouter: EditLookRouterInput {
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
