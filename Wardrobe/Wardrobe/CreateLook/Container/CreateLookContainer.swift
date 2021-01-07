import UIKit

final class CreateLookContainer {
	let viewController: UIViewController
	private(set) weak var router: CreateLookRouterInput!

	class func assemble(with context: CreateLookContext) -> CreateLookContainer {
        let router = CreateLookRouter()
        let interactor = CreateLookInteractor(wardrobeID: context.wardrobeID, ownerLogin: context.creatorLogin)
        let presenter = CreateLookPresenter(router: router, interactor: interactor)
        let viewController = CreateLookViewController()

        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.viewController = viewController

        return CreateLookContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: CreateLookRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct CreateLookContext {
    var wardrobeID: Int
    var creatorLogin: String
}
