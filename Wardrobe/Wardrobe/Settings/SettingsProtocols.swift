import Foundation
import UIKit

protocol SettingsViewInput: class {
    func setUserName(name: String?)
    func setUserImage(with imageUrl: URL?)
    func showAlert(alert: UIAlertController)
}

protocol SettingsViewOutput: class {
    func didImageLoaded(imageData: Data?)
    func didLoadView()
    func didChangeNameTapped()
    func didLogoutTapped()
    func didmyInvitesButtonTap()
}

protocol SettingsInteractorInput: class {
    func logout()
    func saveNewUserName(with name: String)
    func saveNewUserImage(with imageData: Data?)
}

protocol SettingsInteractorOutput: class {
    func didAllKeysDeleted()
    func didNameChanged()
    func showAlert(title: String, message: String)
    func upadateImage()
}

protocol SettingsRouterInput: class {
    func showMyInvites()
}
