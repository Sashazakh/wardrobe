//
//  MainScreenProtocols.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 18.12.2020.
//  
//

import Foundation

protocol MainScreenViewInput: class {
    func reloadData()
    func setUserData(name: String?, imageUrl: URL?)
}

protocol MainScreenViewOutput: class {
    func showDetailDidTap(at indexPath: IndexPath)
    func addWardrobeDidTap()
    func settingsButtonDidTap()
    func didLoadView()
    func getNumberOfWardrobes() -> Int
    func wardrobe(at indexPath: IndexPath) -> WardrobeData?
}

protocol MainScreenInteractorInput: class {
    func loadUserWardobes(for user: String)
}

protocol MainScreenInteractorOutput: class {
    func didReceive(with wardrobes: [WardrobeData])
}

protocol MainScreenRouterInput: class {
    func showDetailWardrope(id: Int)
    func showSettings(login: String, name: String, imageUrl: String)
    func showAddWardobeScreen(for user: String)
}
