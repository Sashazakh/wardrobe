import UIKit

final class SettingsViewController: UIViewController {
	var output: SettingsViewOutput?

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension SettingsViewController: SettingsViewInput {
}
