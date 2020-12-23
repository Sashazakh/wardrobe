import Foundation

final class LoginInteractor {
	weak var output: LoginInteractorOutput?
}

extension LoginInteractor: LoginInteractorInput {
    func login(login: String, password: String) {
        AuthService.shared.login(login: login, password: password) { result in
            if let error = result.error {
                debugPrint(error)
                return
            }

            guard let data = result.data else {
                return
            }

            output?.userSuccesfullyLogin()
        }
    }
}
