import Foundation
import UIKit

protocol InviteViewInput: class {
    func showAlert(alert: UIAlertController)
}

protocol InviteViewOutput: class {
    func didUserTapInviteButton(with login: String)
}

protocol InviteInteractorInput: class {
    func inviteUser(login: String, wardrobeId: Int)
}

protocol InviteInteractorOutput: class {
    func showAlert(title: String, message: String)
}

protocol InviteRouterInput: class {
}
