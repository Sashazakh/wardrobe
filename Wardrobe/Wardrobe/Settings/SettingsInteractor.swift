import Foundation

final class SettingsInteractor {
	weak var output: SettingsInteractorOutput?

    private func handleError(with error: NetworkError) {
        switch error {
        case .networkNotReachable:
            self.output?.showAlert(title: "Ошибка", message: "Не удается подключиться")
        case .userAlreadyExist:
            self.output?.showAlert(title: "Ошибка", message: "Пользователь уже существует")
        default:
            self.output?.showAlert(title: "Ошибка", message: "Мы скоро все починим")
        }
    }

    private func saveNewLogin(with login: String) {
        AuthService.shared.setUserLogin(login: login)
    }
}

extension SettingsInteractor: SettingsInteractorInput {
    func changeUserLogin(with login: String) {
        DataService.shared.changeUserLogin(with: login) { [weak self](result) in
            guard let self = self else { return }

            if let error = result.error {
                self.handleError(with: error)
                return
            }

            self.saveNewLogin(with: login)
            self.output?.didSucessedUpdate(with: login)
            self.output?.showAlert(title: "Поздравляем!", message: "Вы успешно изменили логин!")
        }
    }

    func savePassword(with passowrd: String) {
        DataService.shared.changePassword(password: passowrd) { [weak self](result) in
            guard let self = self else { return }

            if let error = result.error {
                self.handleError(with: error)
                return
            }

            self.output?.showAlert(title: "Поздравляем!", message: "Вы успешно изменили пароль!")
        }
    }

    func saveNewUserImage(with imageData: Data?) {
        guard let imageData = imageData else {
            output?.showAlert(title: "Ошибка",
                              message: "Не удалось загрузить изображение")
            return
        }
        DataService.shared.changePhoto(newPhotoData: imageData) { [weak self](result) in
            guard let self = self else { return }

            if let error = result.error {
                self.handleError(with: error)
                return
            }

            guard let data = result.data else { return }
            if AuthService.shared.getUserImageURL() == nil {
                AuthService.shared.setImageUrl(imageUrl: data.imageUrl)
            }
            self.output?.upadateImage(imageUrl: data.imageUrl)
        }
    }

    func saveNewUserName(with name: String) {
        DataService.shared.changeName(newName: name) { [weak self](result) in
            guard let self = self else { return }

            if let error = result.error {
                self.handleError(with: error)
                return
            }
            DataService.shared.setNewUserName(newName: name)
        }
    }

    func logout() {
        AuthService.shared.dropUser()
        output?.didAllKeysDeleted()
    }

    func loadUserData() {
        let image = AuthService.shared.getUserImageURL()
        let login = AuthService.shared.getUserLogin()
        output?.didReceive(imageUrl: image,
                           userLogin: login)
    }
}
