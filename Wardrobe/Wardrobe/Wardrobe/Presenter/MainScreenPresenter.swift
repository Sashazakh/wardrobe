//
//  MainScreenPresenter.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 18.12.2020.
//  
//

import UIKit

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

    var userName: String?
    var userLogin: String?
    var imageUrlString: String?

    init(router: MainScreenRouterInput, interactor: MainScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }

    private func setUserData() {
        view?.setUserData(name: userName, imageUrl: URL(string: imageUrlString ?? ""))
    }
}

extension MainScreenPresenter: MainScreenViewOutput {
    func didLoadView() {
        setUserData()
        interactor.loadUserWardobes(for: userLogin ?? "")
    }

    func addWardrobeDidTap() {
        router.showAddWardobeScreen(for: userLogin ?? "")
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
