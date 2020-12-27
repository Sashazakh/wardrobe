import Foundation
import UIKit

protocol SettingsViewInput: class {
    func setUserData(name: String?, imageUrl: URL?)
}

protocol SettingsViewOutput: class {
    func didImageLoaded(image: UIImage)
    func didLoadView()
    func didChangeNameTapped()
    func didLogoutTapped()
}

protocol SettingsInteractorInput: class {
    func logout()
}

protocol SettingsInteractorOutput: class {
    func didAllKeysDeleted()
}

protocol SettingsRouterInput: class {
}
