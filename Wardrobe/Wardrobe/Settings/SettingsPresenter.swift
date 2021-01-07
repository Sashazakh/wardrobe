import UIKit
import Kingfisher

final class SettingsPresenter {
	weak var view: SettingsViewInput?

	private let router: SettingsRouterInput
	private let interactor: SettingsInteractorInput

    var userLogin: String?
    var userName: String?
    var imageUrl: String?

    private var newUserName: String?

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
        interactor.loadUserData()
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
            self.newUserName = correctName
            self.saveName(name: correctName)
        }
            alert.addTextField { (textField) in
                textField.placeholder = "Новое имя"
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
    func upadateImage(imageUrl: String) {
        var img = imageUrl
        img += "&apikey=" + DataService.shared.getApiKey()
        KingfisherManager.shared.cache.removeImage(forKey: img)
        view?.setUserImage(with: URL(string: img))
    }

    func didReceive(name: String?, imageUrl: String?, userLogin: String?) {
        if let name = name {
            view?.setUserName(name: name)
        }
        if var imageUrl = imageUrl {
            imageUrl += "&apikey=" + DataService.shared.getApiKey()
            view?.setUserImage(with: URL(string: imageUrl))
        } else {
            view?.setUserImage(with: nil)
        }
        view?.setUserLogin(login: userLogin)
    }

   func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)

        alert.addAction(okAction)
        view?.showAlert(alert: alert)
    }

    func didNameChanged() {
        guard let name = newUserName else { return }
        view?.setUserName(name: name)
    }

    func didAllKeysDeleted() {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate: SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sceneDelegate.logout()
        }
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
