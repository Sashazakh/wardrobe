//
//  MainScreenProtocols.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 18.12.2020.
//  
//

import Foundation
import UIKit

protocol MainScreenViewInput: class {
    func reloadDataWithAnimation()
    func reloadData()
    func startActivity()
    func endActivity()
    func showAlert(alert: UIAlertController)
    func changeEditButton(state: EditButtonState)
}

protocol MainScreenViewOutput: class {
    func showDetailDidTap(at indexPath: IndexPath)
    func addWardrobeDidTap()
    func settingsButtonDidTap()
    func didLoadView()
    func getNumberOfWardrobes() -> Int
    func wardrobe(at indexPath: IndexPath) -> WardrobeData?
    func didEditButtonTap()
    func isEditButtonTapped() -> Bool
    func didDeleteWardrobeTap(with wardrobe: WardrobeData)
    func refreshData()
    func didEditWardrobeTap(at indexPath: IndexPath)
}

protocol MainScreenInteractorInput: class {
    func loadUserWardobes()
    func deleteWardrobe(with id: Int)
    func cleanImageCache(for models: [WardrobeData])
    func getUserLogin() -> String
}

protocol MainScreenInteractorOutput: class {
    func didReceive(with wardrobes: [WardrobeData])
    func showAlert(title: String, message: String)
    func didDelete()
}

protocol MainScreenRouterInput: class {
    func showDetailWardrope(id: Int, name: String, creatorLogin: String)
    func showSettings(login: String, name: String, imageUrl: String)
    func showAddWardobeScreen(for user: String)
    func showEditWardrobe(with wardrobeId: Int)
}
