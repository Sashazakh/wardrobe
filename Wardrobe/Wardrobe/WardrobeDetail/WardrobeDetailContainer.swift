import UIKit

final class WardrobeDetailContainer {
	let viewController: UIViewController
	private(set) weak var router: WardrobeDetailRouterInput!

	class func assemble(with context: WardrobeDetailContext) -> WardrobeDetailContainer {
        let router = WardrobeDetailRouter()
        let interactor = WardrobeDetailInteractor()
        let presenter = WardrobeDetailPresenter(router: router, interactor: interactor)
        let viewController = WardrobeDetailViewController()

        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.viewController = viewController

        presenter.wardrobeId = context.wardrobeId
        presenter.wardrobeName = context.wardrobeName
        presenter.creatorLogin = context.creatorLogin
        return WardrobeDetailContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: WardrobeDetailRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct WardrobeDetailContext {
    let wardrobeId: Int
    let wardrobeName: String
    let creatorLogin: String
}
