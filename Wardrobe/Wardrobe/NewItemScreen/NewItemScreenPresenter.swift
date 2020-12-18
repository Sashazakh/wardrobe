//
//  NewItemScreenPresenter.swift
//  Wardrobe
//
//  Created by kymblc on 18.12.2020.
//  
//

import Foundation

final class NewItemScreenPresenter {
	weak var view: NewItemScreenViewInput?

	private let router: NewItemScreenRouterInput
	private let interactor: NewItemScreenInteractorInput

    init(router: NewItemScreenRouterInput, interactor: NewItemScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension NewItemScreenPresenter: NewItemScreenViewOutput {
}

extension NewItemScreenPresenter: NewItemScreenInteractorOutput {
}
