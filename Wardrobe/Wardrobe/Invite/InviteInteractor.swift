import Foundation

final class InviteInteractor {
	weak var output: InviteInteractorOutput?

    private func handleError(with error: NetworkError) {
        switch error {
        case .networkNotReachable:
            self.output?.showAlert(title: "Ошибка", message: "Неверный логин или приглашение уже отправлено.")
        case .userAlreadyInvite:
            self.output?.showAlert(title: "Ошибка", message: "Пользователь уже находится в гардеробе.")
        default:
            self.output?.showAlert(title: "Ошибка", message: "Мы скоро все починим")
        }
    }
}

extension InviteInteractor: InviteInteractorInput {
    func inviteUser(login: String, wardrobeId: Int) {
        DataService.shared.addUserToWardrobe(with: login,
                                             wardobeId: wardrobeId) { [weak self](result) in
            guard let self = self else { return }

            if let error = result.error {
                self.handleError(with: error)
                return
            }

            self.output?.showAlert(title: "",
                                   message: "Приглашение отправлено!")
        }
    }
}
