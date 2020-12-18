import UIKit

final class LoginContainer {
	let viewController: UIViewController
	private(set) weak var router: LoginRouterInput!

	class func assemble(with context: LoginContext) -> LoginContainer {
        let router = LoginRouter()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(router: router, interactor: interactor)
		let viewController = LoginViewController()

        viewController.output = presenter
		presenter.view = viewController
		interactor.output = presenter

        return LoginContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: LoginRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct LoginContext {
}
