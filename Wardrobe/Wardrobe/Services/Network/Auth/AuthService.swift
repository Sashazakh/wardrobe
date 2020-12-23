import Alamofire

final class AuthService: NetworkService {

    static let shared = AuthService()

    private override init() {
        super.init()
    }
}

extension AuthService: AuthServiceInput {
    func login(login: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let request = AF.request("\(getBaseURL())login?login=\(login)&password=\(password)&apikey=\(getApiKey())")

        request.responseDecodable(of: [LoginResponse].self) { (response) in
            var result = Result<LoginResponse, Error>()

            switch response.result {
            case .success(let data):
                guard response.response?.statusCode == 200 else {
                    result.error = NSError()
                    completion(result)
                    return
                }

                result.data = data.first
            case .failure(let error):
                result.error = error
            }

            completion(result)
        }
    }

    func createNewAccount(login: String, password: String) {

    }
}
