import UIKit

final class SettingsContainer {
	let viewController: UIViewController
	private(set) weak var router: SettingsRouterInput!

	class func assemble(with context: SettingsContext) -> SettingsContainer {
        let router = SettingsRouter()
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter(router: router, interactor: interactor)
	let viewController = SettingsViewController()

        viewController.output = presenter
	presenter.view = viewController
	interactor.output = presenter
	router.viewController = viewController

        return SettingsContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: SettingsRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct SettingsContext {
}
