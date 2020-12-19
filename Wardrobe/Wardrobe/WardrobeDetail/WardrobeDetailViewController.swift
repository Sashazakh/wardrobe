import UIKit

final class WardrobeDetailViewController: UIViewController {
	var output: WardrobeDetailViewOutput?

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension WardrobeDetailViewController: WardrobeDetailViewInput {
}
