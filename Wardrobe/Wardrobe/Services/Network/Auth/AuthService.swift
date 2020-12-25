import Alamofire

final class AuthService: NetworkService {

    static let shared = AuthService()

    private override init() {
        super.init()
    }
}

extension AuthService: AuthServiceInput {
    func login(login: String,
               password: String,
               completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        let request = AF.request("\(getBaseURL())login?login=\(login)&password=\(password)&apikey=\(getApiKey())")
        var result = Result<LoginResponse, NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        request.responseDecodable(of: [LoginResponse].self) { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    result.error = .unknownError
                    completion(result)
                    return
                }

                switch statusCode {
                case ResponseCode.success.code:
                    result.data = data.first
                case ResponseCode.error.code:
                    result.error = .userNotExist
                    completion(result)
                    return
                default:
                    result.error = .unknownError
                    completion(result)
                    return
                }
            case .failure(let error):
                if error.isInvalidURLError {
                    result.error = .connectionToServerError
                } else {
                    result.error = .unknownError
                }

            }

            completion(result)
        }
    }

    func register(login: String,
                  fio: String,
                  password: String,
                  imageData: Data?,
                  completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {

        let parameters: [String: String] = [
            "login": login,
            "username": fio,
            "password": password,
            "image": imageData?.base64EncodedString(options: .lineLength64Characters) ?? "null",
            "apikey": "\(getApiKey())"
        ]

        let request = AF.request("\(getBaseURL())register", method: .post, parameters: parameters)
        var result = Result<LoginResponse, NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        request.responseDecodable(of: [LoginResponse].self) { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    result.error = .unknownError
                    completion(result)
                    return
                }

                switch statusCode {
                case ResponseCode.success.code:
                    result.data = data.first
                case ResponseCode.error.code:
                    result.error = .userAlreadyExist
                    completion(result)
                    return
                default:
                    result.error = .unknownError
                    completion(result)
                    return
                }
            case .failure(let error):
                if error.isInvalidURLError {
                    result.error = .connectionToServerError
                } else {
                    result.error = .unknownError
                }
            }

            completion(result)
        }
    }
}
