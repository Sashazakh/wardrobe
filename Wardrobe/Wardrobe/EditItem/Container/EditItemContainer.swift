import UIKit

final class EditItemContainer {
	let viewController: UIViewController
	private(set) weak var router: EditItemRouterInput!

	class func assemble(with context: EditItemContext) -> EditItemContainer {
        let router = EditItemRouter()
        let interactor = EditItemInteractor(itemID: context.itemID)
        let presenter = EditItemPresenter(router: router, interactor: interactor)
		let viewController = EditItemViewController()

        viewController.output = presenter
		presenter.view = viewController
		interactor.output = presenter
        router.viewController = viewController

        return EditItemContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: EditItemRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct EditItemContext {
    var itemID: Int
}
