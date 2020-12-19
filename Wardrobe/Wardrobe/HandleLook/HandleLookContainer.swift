import UIKit

final class HandleLookContainer {
	let viewController: UIViewController
	private(set) weak var router: HandleLookRouterInput!

	class func assemble(with context: HandleLookContext) -> HandleLookContainer {
        let router = HandleLookRouter()
        let interactor = HandleLookInteractor()
        let presenter = HandleLookPresenter(router: router, interactor: interactor)
	let viewController = HandleLookViewController()

        viewController.output = presenter
	presenter.view = viewController
	interactor.output = presenter
	router.viewController = viewController

        return HandleLookContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: HandleLookRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct HandleLookContext {
}
