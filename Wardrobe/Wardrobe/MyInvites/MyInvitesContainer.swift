//
//  MyInvitesContainer.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 28.12.2020.
//  
//

import UIKit

final class MyInvitesContainer {
	let viewController: UIViewController
	private(set) weak var router: MyInvitesRouterInput!

	class func assemble(with context: MyInvitesContext) -> MyInvitesContainer {
        let router = MyInvitesRouter()
        let interactor = MyInvitesInteractor()
        let presenter = MyInvitesPresenter(router: router, interactor: interactor)
		let viewController = MyInvitesViewController()

        viewController.output = presenter
		presenter.view = viewController
		interactor.output = presenter

        return MyInvitesContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: MyInvitesRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct MyInvitesContext {
}
