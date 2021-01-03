import UIKit

final class EditWardrobeContainer {
	let viewController: UIViewController
	private(set) weak var router: EditWardrobeRouterInput!

	class func assemble(with context: EditWardrobeContext) -> EditWardrobeContainer {
        let router = EditWardrobeRouter()
        let interactor = EditWardrobeInteractor(wardrobeID: context.wardrobeID)
        let presenter = EditWardrobePresenter(router: router, interactor: interactor)
        let viewController = EditWardrobeViewController()

        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.viewController = viewController

        return EditWardrobeContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: EditWardrobeRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct EditWardrobeContext {
    var wardrobeID: Int
}
