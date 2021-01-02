import UIKit

final class AllClothesRouter {
    weak var viewController: UIViewController?
}

extension AllClothesRouter: AllClothesRouterInput {
    func showAlert(title: String, message: String) {
        guard let view = viewController else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)

        alert.addAction(okAction)

        view.present(alert, animated: true, completion: nil)
    }
}
