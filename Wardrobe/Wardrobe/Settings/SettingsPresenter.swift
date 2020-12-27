import Foundation
import UIKit

final class SettingsPresenter {
	weak var view: SettingsViewInput?

	private let router: SettingsRouterInput
	private let interactor: SettingsInteractorInput

    var userLogin: String?
    var userName: String?
    var imageUrl: String?
    init(router: SettingsRouterInput, interactor: SettingsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }

    private func setUserData() {
        view?.setUserData(name: userName, imageUrl: URL(string: imageUrl ?? ""))
    }
}

extension SettingsPresenter: SettingsViewOutput {
    func didLoadView() {
        setUserData()
    }

    func didImageLoaded(image: UIImage) {

    }

    func didChangeNameTapped() {

    }

    func didLogoutTapped() {
        interactor.logout()
    }
}

extension SettingsPresenter: SettingsInteractorOutput {
    func didAllKeysDeleted() {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate: SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sceneDelegate.logout()
        }
    }
}
