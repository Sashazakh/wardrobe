import UIKit

final class RegisterContainer {
	let viewController: UIViewController
	private(set) weak var router: RegisterRouterInput!

	class func assemble(with context: RegisterContext) -> RegisterContainer {
        let router = RegisterRouter()
        let interactor = RegisterInteractor(termsAccepted: context.termsAccepted)
        let presenter = RegisterPresenter(router: router, interactor: interactor)
		let viewController = RegisterViewController()

        viewController.output = presenter
		presenter.view = viewController
		interactor.output = presenter
        router.viewController = viewController

        return RegisterContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: RegisterRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct RegisterContext {
    var termsAccepted: Bool
}
