import UIKit

final class InviteContainer {
	let viewController: UIViewController
	private(set) weak var router: InviteRouterInput!

	class func assemble(with context: InviteContext) -> InviteContainer {
        let router = InviteRouter()
        let interactor = InviteInteractor()
        let presenter = InvitePresenter(router: router, interactor: interactor)
        let viewController = InviteViewController()

        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.viewController = viewController

        return InviteContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: InviteRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct InviteContext {
}
