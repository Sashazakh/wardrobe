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
    func setUserName(name: String?)
    func setUserImage(with imageUrl: URL?)
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
    func didDeleteWardrobeTap(with id: Int)
}

protocol MainScreenInteractorInput: class {
    func loadUserWardobes()
    func loadUserData()
    func deleteWardrobe(with id: Int)
}

protocol MainScreenInteractorOutput: class {
    func didReceive(with wardrobes: [WardrobeData])
    func didReceive(name: String?, imageUrl: String?)
    func showAlert(title: String, message: String)
    func didDelete()
}

protocol MainScreenRouterInput: class {
    func showDetailWardrope(id: Int, name: String)
    func showSettings(login: String, name: String, imageUrl: String)
    func showAddWardobeScreen(for user: String)
}
