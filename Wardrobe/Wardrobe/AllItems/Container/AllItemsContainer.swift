import UIKit

final class AllItemsContainer {
	let viewController: UIViewController
	private(set) weak var router: AllItemsRouterInput!

	class func assemble(with context: AllItemsContext) -> AllItemsContainer {
        let router = AllItemsRouter()
        let interactor = AllItemsInteractor()
        let presenter = AllItemsPresenter(router: router, interactor: interactor)
        let viewController = AllItemsViewController()

        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.viewController = viewController

        return AllItemsContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: AllItemsRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct AllItemsContext {
}
