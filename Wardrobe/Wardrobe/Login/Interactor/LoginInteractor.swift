import Foundation

final class LoginInteractor {
	weak var output: LoginInteractorOutput?

    private func convertToLoginData(with rawData: LoginResponse) -> LoginData {
        return LoginData(userName: rawData.userName, imageURL: rawData.imageURL)
    }
}

extension LoginInteractor: LoginInteractorInput {
    func login(login: String, password: String) {
        guard password.count >= Constants.minPasswordSymbs else {
            output?.showAlert(title: "Ошибка", message: "Пользователь не найден")
            return
        }

        AuthService.shared.login(login: login, password: password) { [weak self] result in
            guard result.error == nil else {
                guard let networkError = result.error else {
                    return
                }

                switch networkError {
                case .networkNotReachable:
                    self?.output?.showAlert(title: "Ошибка", message: "Не удается подключиться")
                case .userNotExist:
                    self?.output?.showAlert(title: "Ошибка", message: "Пользователь не найден")
                default:
                    self?.output?.showAlert(title: "Ошибка", message: "Мы скоро все починим")
                }

                return
            }

            guard let data = result.data,
                  let self = self else {
                return
            }

            self.output?.updateModel(model: self.convertToLoginData(with: data))
            self.output?.userSuccesfullyLogin()
        }
    }
}

extension LoginInteractor {
    private struct Constants {
        static let minPasswordSymbs: Int = 8
    }
}
