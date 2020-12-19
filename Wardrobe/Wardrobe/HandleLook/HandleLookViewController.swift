import UIKit

final class HandleLookViewController: UIViewController {
	var output: HandleLookViewOutput?

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension HandleLookViewController: HandleLookViewInput {
}
