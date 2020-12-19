import UIKit

final class AllClothesViewController: UIViewController {
	var output: AllClothesViewOutput?

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension AllClothesViewController: AllClothesViewInput {
}
