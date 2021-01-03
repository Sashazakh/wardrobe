import Foundation

final class RegisterInteractor {
	weak var output: RegisterInteractorOutput?

    private var termsAccepted: Bool

    init(termsAccepted: Bool) {
        self.termsAccepted = termsAccepted
    }

    private func convertToRegisterData(with rawData: LoginResponse) -> RegisterData {
        return RegisterData(login: rawData.login, userName: rawData.userName, imageURL: rawData.imageURL)
    }
}

extension RegisterInteractor: RegisterInteractorInput {
    func toggleTermsState() {
            termsAccepted = !termsAccepted
        }

    func termsAreAccepted() -> Bool {
        return termsAccepted
    }

    func register(login: String, fio: String, password: String, imageData: Data?) {
        guard termsAccepted else {
            output?.showAlert(title: "Ошибка", message: "Примите пользовательское соглашение")
            return
        }

        guard password.count >= Constants.minPasswordSymbs else {
            output?.showAlert(title: "Ошибка", message: "Пароль должен содержать не менее 8 символов")
            return
        }

        AuthService.shared.register(login: login,
                                    fio: fio,
                                    password: password,
                                    imageData: imageData) { [weak self] result in
            guard result.error == nil else {
                guard let networkError = result.error else {
                    return
                }

                switch networkError {
                case .networkNotReachable:
                    self?.output?.showAlert(title: "Ошибка", message: "Не удается подключиться")
                case .userAlreadyExist:
                    self?.output?.showAlert(title: "Ошибка", message: "Пользователь уже сущуствует")
                default:
                    self?.output?.showAlert(title: "Ошибка", message: "Мы скоро все починим")
                }

                return
            }

            guard let data = result.data,
                  let self = self else {
                return
            }

            self.output?.updateModel(model: self.convertToRegisterData(with: data))
            self.output?.userSuccesfullyRegistered()
        }
    }
}

extension RegisterInteractor {
    private struct Constants {
        static let minPasswordSymbs: Int = 8
    }
}
