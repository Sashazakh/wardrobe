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
        view?.setUserName(name: userName)
        view?.setUserImage(with: URL(string: imageUrl ?? ""))
    }

    private func saveName(name: String) {
        if !name.isEmpty {
            interactor.saveNewUserName(with: name)
        }
    }
}

extension SettingsPresenter: SettingsViewOutput {
    func didImageLoaded(imageData: Data?) {
        interactor.saveNewUserImage(with: imageData)
    }

    func didLogoutTapped() {
        let alert = UIAlertController(title: Constants.headLogoutWarningMessage,
                                      message: Constants.logoutWarningMessage,
                                      preferredStyle: UIAlertController.Style.alert )
        let reset = UIAlertAction(title: "Выход", style: .default) { [self] (_) in
            self.interactor.logout()
        }
        alert.addAction(reset)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(cancel)
        view?.showAlert(alert: alert)
    }

    func didLoadView() {
        setUserData()
    }

    func didChangeNameTapped() {
        let alert = UIAlertController(title: Constants.changeNameTitle,
                                      message: Constants.changeNameMessage,
                                      preferredStyle: UIAlertController.Style.alert)
        let save = UIAlertAction(title: "Сохранить", style: .default) { (_) in
            var correctName = ""
            if let nameTextField = alert.textFields?[0] {
                if let name = nameTextField.text {
                    if !name.isEmpty {
                            correctName = name
                        }
                    }
                }
                self.saveName(name: correctName)
        }
            alert.addTextField { (textField) in
                textField.placeholder = "Новое имя"
                textField.keyboardType = .asciiCapable
            }
            alert.addAction(save)
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
            alert.addAction(cancel)
            view?.showAlert(alert: alert)
    }

    func didImageLoaded(imageData: Data) {
        interactor.saveNewUserImage(with: imageData)
    }

    func didmyInvitesButtonTap() {
        router.showMyInvites()
    }
}

extension SettingsPresenter: SettingsInteractorOutput {
   func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)

        alert.addAction(okAction)
        view?.showAlert(alert: alert)
    }

    func didReceive(with name: String) {
        view?.setUserName(name: name)
    }

    func didAllKeysDeleted() {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate: SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sceneDelegate.logout()
        }
    }

    func upadateImage() {
        view?.setUserImage(with: URL(string: imageUrl ?? ""))
    }
}

extension SettingsPresenter {
    struct Constants {
        static let headLogoutWarningMessage: String = "Выход"
        static let logoutWarningMessage: String = "Вы собираетесь выйти.Ваши данные не будут удалены."
        static let changeNameTitle: String = "Изменение имени"
        static let changeNameMessage: String = "Введите новое имя"
    }
}
