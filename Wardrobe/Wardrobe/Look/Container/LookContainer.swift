import UIKit

final class LookContainer {
	let viewController: UIViewController
	private(set) weak var router: LookRouterInput!

	class func assemble(with context: LookContext) -> LookContainer {
        let router = LookRouter()
        let interactor = LookInteractor(lookID: context.lookID, ownerLogin: context.ownerLogin)
        let presenter = LookPresenter(router: router, interactor: interactor)
        let viewController = LookViewController()

        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.viewController = viewController

        return LookContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: LookRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct LookContext {
    var lookID: Int

    var ownerLogin: String
}
