import UIKit

final class EditLookContainer {
	let viewController: UIViewController
	private(set) weak var router: EditLookRouterInput!

	class func assemble(with context: EditLookContext) -> EditLookContainer {
        let router = EditLookRouter()
        let interactor = EditLookInteractor()
        let presenter = EditLookPresenter(router: router, interactor: interactor)
	let viewController = EditLookViewController()

        viewController.output = presenter
	presenter.view = viewController
	interactor.output = presenter
	router.viewController = viewController

        return EditLookContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: EditLookRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct EditLookContext {
}
