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

    private func handleNewName(name: String) {
        output?.didReceive(with: name)
    }

    private func imageDidUpdate() {

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

            self.imageDidUpdate()
        }
    }

    func saveNewUserName(with name: String) {
        DataService.shared.changeName(newName: name) { [weak self](result) in
            guard let self = self else { return }

            if let error = result.error {
                self.handleError(with: error)
                return
            }

            guard let name = result.data else {
                return }

            self.handleNewName(name: name)
        }
    }

    func logout() {
        AuthService.shared.dropUser()
        output?.didAllKeysDeleted()
    }
}
