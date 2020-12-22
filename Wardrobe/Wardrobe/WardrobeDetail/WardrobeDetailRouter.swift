import UIKit

final class WardrobeDetailRouter {
    weak var viewController: UIViewController?
}

extension WardrobeDetailRouter: WardrobeDetailRouterInput {
    func showLookScreen() {
        let lookVC = LookContainer.assemble(with: LookContext()).viewController

        lookVC.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(lookVC, animated: true)
    }
}
