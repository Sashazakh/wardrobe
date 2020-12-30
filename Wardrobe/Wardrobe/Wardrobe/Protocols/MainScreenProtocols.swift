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
    func setUserName(name: String?)
    func setUserImage(with imageUrl: URL?)
    func startActivity()
    func endActivity()
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
    func loadUserData()
}

protocol MainScreenInteractorOutput: class {
    func didReceive(with wardrobes: [WardrobeData])
    func didReceive(name: String?, imageUrl: String?)
}

protocol MainScreenRouterInput: class {
    func showDetailWardrope(id: Int)
    func showSettings(login: String, name: String, imageUrl: String)
    func showAddWardobeScreen(for user: String)
}
