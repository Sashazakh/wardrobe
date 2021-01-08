import UIKit

final class AllClothesContainer {
	let viewController: UIViewController
	private(set) weak var router: AllClothesRouterInput!

	class func assemble(with context: AllClothesContext) -> AllClothesContainer {
        let router = AllClothesRouter()
        let interactor = AllClothesInteractor()
        let presenter = AllClothesPresenter(router: router, interactor: interactor)
        let viewController = AllClothesViewController()

        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.viewController = viewController

        return AllClothesContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: AllClothesRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct AllClothesContext {
    var login: String

    var imageURL: String?
}
