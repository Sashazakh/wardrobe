import UIKit

final class WardrobeUsersContainer {
	let viewController: UIViewController
	private(set) weak var router: WardrobeUsersRouterInput!

	class func assemble(with context: WardrobeUsersContext) -> WardrobeUsersContainer {
        let router = WardrobeUsersRouter()
        let interactor = WardrobeUsersInteractor()
        let presenter = WardrobeUsersPresenter(router: router, interactor: interactor)
        let viewController = WardrobeUsersViewController()

        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.viewController = viewController

        presenter.wardrobeId = context.wardrobeId
        presenter.wardrobeName = context.wardrobeName
        presenter.loginOfCreator = context.loginOfCreator

        return WardrobeUsersContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: WardrobeUsersRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct WardrobeUsersContext {
    let wardrobeId: Int
    let wardrobeName: String
    let loginOfCreator: String
}
