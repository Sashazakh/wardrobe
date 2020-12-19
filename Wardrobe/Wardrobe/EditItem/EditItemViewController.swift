import UIKit

final class EditItemViewController: UIViewController {
	var output: EditItemViewOutput?

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension EditItemViewController: EditItemViewInput {
}
