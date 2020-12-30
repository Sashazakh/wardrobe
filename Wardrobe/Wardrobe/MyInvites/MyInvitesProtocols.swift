//
//  MyInvitesProtocols.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 28.12.2020.
//  
//

import Foundation
import UIKit

protocol MyInvitesViewInput: class {
    func showAlert(alert: UIAlertController)
    func reloadData()
}

protocol MyInvitesViewOutput: class {
    func didLoadView()
    func didInviteButtonTapped(at indexPath: IndexPath)
    func getInvite(at indexPath: IndexPath) -> MyInvitesData?
    func getNumberOfInvites() -> Int
}

protocol MyInvitesInteractorInput: class {
    func loadInvites()
    func didUserAcceptWardrobe(with id: Int)
    func didUserDenyWardrobe(with id: Int)
}

protocol MyInvitesInteractorOutput: class {
    func showAlert(title: String, message: String)
    func didReceive(with invites: [MyInvitesData])
    func removeWardrobe()
}

protocol MyInvitesRouterInput: class {
}
