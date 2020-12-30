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
}

extension MainScreenPresenter: MainScreenViewOutput {
    func didLoadView() {
        view?.startActivity()
        interactor.loadUserData()
        interactor.loadUserWardobes(for: userLogin ?? "")
    }

    func addWardrobeDidTap() {
        router.showAddWardobeScreen(for: userLogin ?? "")
    }

    func showDetailDidTap(at indexPath: IndexPath) {
        let wardobeData = userWardrobes[indexPath.row]
        router.showDetailWardrope(id: wardobeData.id)
    }

    func settingsButtonDidTap() {
        router.showSettings(login: userLogin ?? "", name: userName ?? "", imageUrl: imageUrlString ?? "")
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
        view?.endActivity()
        self.userWardrobes = wardrobes
    }

    func didReceive(name: String?, imageUrl: String?) {
        if let name = name {
            view?.setUserName(name: name)
        }
        view?.setUserImage(with: URL(string: imageUrl ?? ""))
    }
}
