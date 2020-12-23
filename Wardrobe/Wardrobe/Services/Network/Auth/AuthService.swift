import Alamofire

final class AuthService: NetworkService {

    static let shared = AuthService()

    private override init() {
        super.init()
    }
}

extension AuthService: AuthServiceInput {
    func login(login: String, password: String, completion: (Result<LoginResponse, Error>) -> Void) {
        let request = AF.request("\(getBaseURL())login?login=\(login)&password=\(password)&apikey=\(getApiKey())")

        request.response { (response) in
            debugPrint(response)
        }
    }

    func createNewAccount(login: String, password: String) {

    }
}
