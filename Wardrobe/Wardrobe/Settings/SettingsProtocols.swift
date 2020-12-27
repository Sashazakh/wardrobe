import Foundation
import UIKit

protocol SettingsViewInput: class {
    func setUserData(name: String?, imageUrl: URL?)
}

protocol SettingsViewOutput: class {
    func didImageLoaded(image: UIImage)
    func didLoadView()
}

protocol SettingsInteractorInput: class {
}

protocol SettingsInteractorOutput: class {
}

protocol SettingsRouterInput: class {
}
