import UIKit

final class LookViewController: UIViewController {
	var output: LookViewOutput?

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension LookViewController: LookViewInput {
}
