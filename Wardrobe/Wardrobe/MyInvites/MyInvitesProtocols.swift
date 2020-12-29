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
}

protocol MyInvitesViewOutput: class {
    func didInviteButtonTapped(at indexPath: IndexPath)
}

protocol MyInvitesInteractorInput: class {
    func didUserAcceptWardrobe(with id: Int)
    func didUserDenyWardrobe(with id: Int)
}

protocol MyInvitesInteractorOutput: class {
}

protocol MyInvitesRouterInput: class {
}
