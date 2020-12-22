import UIKit

final class CreateLookRouter {
    weak var viewController: UIViewController?
}

extension CreateLookRouter: CreateLookRouterInput {
    func showWardrobeDetailScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
