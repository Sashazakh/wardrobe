import UIKit

final class NewItemScreenRouter {
    weak var viewController: UIViewController?
}

extension NewItemScreenRouter: NewItemScreenRouterInput {
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
