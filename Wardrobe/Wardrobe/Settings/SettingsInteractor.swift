import Foundation

final class SettingsInteractor {
	weak var output: SettingsInteractorOutput?

    private func handleError(with error: NetworkError) {
        switch error {
        case .networkNotReachable:
            self.output?.showAlert(title: "Ошибка", message: "Не удается подключиться")
        default:
            self.output?.showAlert(title: "Ошибка", message: "Мы скоро все починим")
        }
    }
}

extension SettingsInteractor: SettingsInteractorInput {
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
            self.output?.didNameChanged()
        }
    }

    func logout() {
        AuthService.shared.dropUser()
        output?.didAllKeysDeleted()
    }

    func loadUserData() {
        let name = AuthService.shared.getUserName()
        let image = AuthService.shared.getUserImageURL()
        output?.didReceive(name: name, imageUrl: image)
    }
}
