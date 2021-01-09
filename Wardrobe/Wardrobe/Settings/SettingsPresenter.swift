import UIKit
import Kingfisher

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
        view?.setUserImage(with: URL(string: imageUrl ?? ""))
    }

    private func checkPassword(main: String, repeatPassword: String) {
        if main.isEmpty || repeatPassword.isEmpty {
            self.showAlert(title: "Ошибка!", message: "Вы заполнили не все поля!")
            return
        }

        if main != repeatPassword {
            self.showAlert(title: "Ошибка!", message: "Пароли не совпадают!")
            return
        }

        if main.count < Constants.numberOfSymbolsInPassword {
            self.showAlert(title: "Ошибка!", message: "Длина пароля менее 6 символов!")
            return
        }

        interactor.savePassword(with: main)
    }

    private func checkNewLogin(with login: String) {
        if login.isEmpty {
            self.showAlert(title: "Ошибка!", message: "Вы не ввели логин.")
            return
        }

        if login.contains(" ") {
            self.showAlert(title: "Ошибка!", message: "Логин должен быть без пробела")
            return
        }

        interactor.changeUserLogin(with: login)
    }
}

extension SettingsPresenter: SettingsViewOutput {
    func didChangeLoginTapped() {
        let alert = UIAlertController(title: Constants.changeNameTitle,
                                      message: Constants.changeNameMessage,
                                      preferredStyle: UIAlertController.Style.alert)
        let save = UIAlertAction(title: "Сохранить", style: .default) { (_) in
            var login = ""
            if let loginTextField = alert.textFields?[0] {
                login = loginTextField.text ?? ""
            }

            self.checkNewLogin(with: login)
        }
            alert.addTextField { (textField) in
                textField.placeholder = Constants.changeLoginPlaceholder
                textField.keyboardType = .asciiCapable
            }

            alert.addAction(save)
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
            alert.addAction(cancel)
            view?.showAlert(alert: alert)
    }

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

    func didChangePasswordTapped() {
        let alert = UIAlertController(title: Constants.changePasswordTitle,
                                      message: Constants.changePasswordMessage,
                                      preferredStyle: UIAlertController.Style.alert)
        let save = UIAlertAction(title: "Сохранить", style: .default) { (_) in
            var password = ""
            if let passwordTextField = alert.textFields?[0] {
                password = passwordTextField.text ?? ""
            }
            var repeatPassword = ""
            if let repeatPasswordTextField = alert.textFields?[1] {
                repeatPassword = repeatPasswordTextField.text ?? ""
            }
            self.checkPassword(main: password, repeatPassword: repeatPassword)
        }
            alert.addTextField { (textField) in
                textField.placeholder = Constants.changePasswordMainPlaceholder
                textField.isSecureTextEntry = true
                textField.keyboardType = .asciiCapable
            }

            alert.addTextField { (textField) in
                textField.placeholder = Constants.repeadPasswordMainPlaceholder
                textField.isSecureTextEntry = true
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

    func didMyInvitesButtonTap() {
        router.showMyInvites()
    }
}

extension SettingsPresenter: SettingsInteractorOutput {
    func didSucessedUpdate(with login: String) {
        view?.setUserLogin(login: login)
    }

    func upadateImage(imageUrl: String) {
        var img = imageUrl
        img += "&apikey=" + DataService.shared.getApiKey()
        KingfisherManager.shared.cache.removeImage(forKey: img)
        view?.setUserImage(with: URL(string: img))
    }

    func didReceive(imageUrl: String?, userLogin: String?) {
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
        static let logoutWarningMessage: String = "Вы собираетесь выйти.\nВаши данные не будут удалены."
        static let changePasswordTitle: String = "Изменение пароля"
        static let changePasswordMessage: String = "Введите новый пароль"
        static let changePasswordMainPlaceholder: String = "Новый пароль"
        static let repeadPasswordMainPlaceholder: String = "Повторите пароль"
        static let changeNameTitle: String = "Изменение логина"
        static let changeNameMessage: String = "Введите новый логин"
        static let changeLoginPlaceholder: String = "Новый логин"
        static let numberOfSymbolsInPassword: Int = 6
    }
}
