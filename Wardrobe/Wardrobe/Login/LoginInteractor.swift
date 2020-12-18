import Foundation

final class LoginInteractor {
	weak var output: LoginInteractorOutput?
}

extension LoginInteractor: LoginInteractorInput {
}
