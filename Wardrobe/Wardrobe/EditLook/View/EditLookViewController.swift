import UIKit

final class EditLookViewController: UIViewController {
    var output: EditLookViewOutput?

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension EditLookViewController: EditLookViewInput {
}
