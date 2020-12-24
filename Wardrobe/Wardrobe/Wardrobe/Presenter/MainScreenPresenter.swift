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

    private var userWardrobes: [WardrobeData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }

    init(router: MainScreenRouterInput, interactor: MainScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MainScreenPresenter: MainScreenViewOutput {
    func didLoadView() {
        interactor.loadUserWardobes()
    }

    func addWardrobeDidTap() {
        router.showAddWardobeScreen()
    }

    func showDetailDidTap(at indexPath: IndexPath) {
        router.showDetailWardrope(id: indexPath.row)
    }

    func settingsButtonDidTap() {
        router.showSettings()
    }

    func getNumberOfWardrobes() -> Int {
        return userWardrobes.count
    }

    func wardrobe(at indexPath: IndexPath) -> WardrobeData? {
        return userWardrobes[indexPath.row]
    }
}

extension MainScreenPresenter: MainScreenInteractorOutput {
    func didReceive(with wardrobes: [WardrobeData]) {
        self.userWardrobes = wardrobes
    }

}
