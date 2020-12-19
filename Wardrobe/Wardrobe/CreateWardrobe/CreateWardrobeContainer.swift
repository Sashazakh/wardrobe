//
//  CreateWardrobeContainer.swift
//  Wardrobe
//
//  Created by kymblc on 19.12.2020.
//  
//

import UIKit

final class CreateWardrobeContainer {
	let viewController: UIViewController
	private(set) weak var router: CreateWardrobeRouterInput!

	class func assemble(with context: CreateWardrobeContext) -> CreateWardrobeContainer {
        let router = CreateWardrobeRouter()
        let interactor = CreateWardrobeInteractor()
        let presenter = CreateWardrobePresenter(router: router, interactor: interactor)
		let viewController = CreateWardrobeViewController()

        viewController.output = presenter
		presenter.view = viewController
		interactor.output = presenter

        return CreateWardrobeContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: CreateWardrobeRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct CreateWardrobeContext {
}
