import Foundation

final class LoginInteractor {
	weak var output: LoginInteractorOutput?
}

extension LoginInteractor: LoginInteractorInput {
    func login(login: String, password: String) {
        AuthService.shared.login(login: login, password: password) { [weak self] in

        }
    }
}
