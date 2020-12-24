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
    func loadUserWardobes()
}

protocol MainScreenInteractorOutput: class {
    func didReceive(with wardrobes: [WardrobeData])
}

protocol MainScreenRouterInput: class {
    func showDetailWardrope(id: Int)
    func showSettings()
    func showAddWardobeScreen()
}
