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

    func login(login: String, password: String, completion: () -> Void) {
        let request = AF.request("\(getBaseURL())/login?login=\(login)&password=\(password)&apikey=\(getApiKey())")

        request.response { (response) in
            debugPrint(response)
        }
    }
}

extension AuthService {
    struct LoginResponse {
        var userName: String

        var imageUrl: String
    }
}
