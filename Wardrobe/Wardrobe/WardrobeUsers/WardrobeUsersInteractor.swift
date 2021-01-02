import Foundation

final class WardrobeUsersInteractor {
	weak var output: WardrobeUsersInteractorOutput?

    private func handleError(with error: NetworkError) {
        switch error {
        case .networkNotReachable:
            self.output?.showAlert(title: "Ошибка", message: "Не удается подключиться")
        default:
            self.output?.showAlert(title: "Ошибка", message: "Мы скоро все починим")
        }
    }

    private func handleWardrobeUsers(with userRaw: [WardrobeUserRaw]) {
        let wardrobeUsers: [WardrobeUserData] = userRaw.map({ WardrobeUserData(with: $0) })
        output?.didReceive(with: wardrobeUsers)
    }
}

extension WardrobeUsersInteractor: WardrobeUsersInteractorInput {
    func deleteUser(login: String, wardrobeId: Int) {
        DataService.shared.deleteUserFromWardrobe(wardrobeId: wardrobeId,
                                                  login: login) { [weak self](result) in
            guard let self = self else { return }
            if let error = result.error {
                self.handleError(with: error)
                return
            }

            self.output?.didDelete()
        }
    }

    func loadWardrobeUsers(with wardrobeId: Int) {
        DataService.shared.getWardroeUsers(with: wardrobeId) { [weak self](result) in
            guard let self = self else { return }

            if let error = result.error {
                self.handleError(with: error)
                return
            }

            guard let wardobeUsers = result.data else {
                return
            }

            self.handleWardrobeUsers(with: wardobeUsers)
        }
    }
}
