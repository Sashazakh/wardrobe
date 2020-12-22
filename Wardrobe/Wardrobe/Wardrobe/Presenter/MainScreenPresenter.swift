//
//  MainScreenPresenter.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 18.12.2020.
//  
//

import Foundation

final class MainScreenPresenter {
	weak var view: MainScreenViewInput?

	private let router: MainScreenRouterInput
	private let interactor: MainScreenInteractorInput

    init(router: MainScreenRouterInput, interactor: MainScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MainScreenPresenter: MainScreenViewOutput {
    func itemDidTap(at indexPath: IndexPath) {
        router.showDetailWardrope(id: indexPath.row)
    }

    func settingsButtonDidTap() {
        router.showSettings()
    }
}

extension MainScreenPresenter: MainScreenInteractorOutput {
}
