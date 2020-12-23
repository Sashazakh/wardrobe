import Foundation

final class LoginInteractor {
	weak var output: LoginInteractorOutput?

    private func convertToLoginData(with rawData: LoginResponse) -> LoginData {
        return LoginData(userName: rawData.userName, imageURL: "")
    }
}

extension LoginInteractor: LoginInteractorInput {
    func login(login: String, password: String) {
        AuthService.shared.login(login: login, password: password) { [weak self] result in
            if result.error != nil {
                self?.output?.showAlert(title: "Ошибка", message: "Такого пользователя не существует")
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
