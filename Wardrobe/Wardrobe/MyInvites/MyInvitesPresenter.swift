//
//  MyInvitesPresenter.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 28.12.2020.
//  
//

import Foundation

final class MyInvitesPresenter {
	weak var view: MyInvitesViewInput?

	private let router: MyInvitesRouterInput
	private let interactor: MyInvitesInteractorInput

    init(router: MyInvitesRouterInput, interactor: MyInvitesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MyInvitesPresenter: MyInvitesViewOutput {
}

extension MyInvitesPresenter: MyInvitesInteractorOutput {
}
