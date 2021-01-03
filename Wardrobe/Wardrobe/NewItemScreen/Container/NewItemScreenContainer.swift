import UIKit

final class NewItemScreenContainer {
	let viewController: UIViewController
	private(set) weak var router: NewItemScreenRouterInput!

	class func assemble(with context: NewItemScreenContext) -> NewItemScreenContainer {
        let router = NewItemScreenRouter()
        let interactor = NewItemScreenInteractor(category: context.category)
        let presenter = NewItemScreenPresenter(router: router, interactor: interactor)
		let viewController = NewItemScreenViewController()

        viewController.output = presenter
		presenter.view = viewController
		interactor.output = presenter
        router.viewController = viewController

        return NewItemScreenContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: NewItemScreenRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct NewItemScreenContext {
    var category: String
}
