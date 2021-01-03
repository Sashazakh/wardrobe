import UIKit

final class SetupLookContainer {
	let viewController: UIViewController
	private(set) weak var router: SetupLookRouterInput!

	class func assemble(with context: SetupLookContext) -> SetupLookContainer {
        let router = SetupLookRouter()
        let interactor = SetupLookInteractor(wardrobeID: context.wardrobeID, itemIDs: context.choosedItemsID)
        let presenter = SetupLookPresenter(router: router, interactor: interactor)
        let viewController = SetupLookViewController()

        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.viewController = viewController

        return SetupLookContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: SetupLookRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct SetupLookContext {
    var wardrobeID: Int
    var choosedItemsID: [Int]
}
