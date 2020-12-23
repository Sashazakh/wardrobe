import Alamofire

final class AuthService: NetworkService {

    static let shared = AuthService()

    private override init() {
        super.init()
    }
}

extension AuthService: AuthServiceInput {
    func createNewAccount(login: String, password: String) {

    }

    func login(login: String, password: String) {

    }
}
