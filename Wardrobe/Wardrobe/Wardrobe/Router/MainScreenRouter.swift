import UIKit

final class MainScreenRouter {
    weak var viewController: MainScreenViewController?
}

extension MainScreenRouter: MainScreenRouterInput {
    func showDetailWardrope(id: Int) {
        print(id)
        let vc = WardrobeDetailContainer.assemble(with: WardrobeDetailContext()).viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

}
