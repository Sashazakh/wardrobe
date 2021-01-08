import Alamofire

final class AuthService: NetworkService {

    static let shared = AuthService()

    private override init() {
        super.init()
    }

    private func saveUser(login: String,
                          password: String,
                          imageURL: String?,
                          imageId: Int?) {

        UserDefaults.standard.setValue(true, forKey: Constants.authKey)

        UserDefaults.standard.setValue(login, forKey: Constants.loginKey)
        UserDefaults.standard.setValue(password, forKey: Constants.passwordKey)

        guard let imageURL = imageURL else {
            return
        }

        UserDefaults.standard.setValue(imageURL, forKey: Constants.imageURLKey)

        guard let imageId = imageId else { return }

        UserDefaults.standard.setValue(imageId, forKey: Constants.imageIdKey)
    }
}

extension AuthService: AuthServiceInput {
    func isAuthorized(completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        var result = Result<Bool, NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        guard UserDefaults.standard.bool(forKey: Constants.authKey) == true else {
            result.data = false
            completion(result)
            return
        }

        guard let login = UserDefaults.standard.string(forKey: Constants.loginKey),
              let password = UserDefaults.standard.string(forKey: Constants.passwordKey) else {
            result.data = false
            completion(result)
            return
        }

        self.login(login: login,
                   password: password) { (loginResult) in
            guard loginResult.error == nil else {
                guard let networkError = loginResult.error else {
                    return
                }

                result.error = networkError
                completion(result)
                return
            }

            guard loginResult.data != nil else {
                return
            }

            result.data = true
            completion(result)
        }
    }

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

                completion(result)
            }

            self.saveUser(login: login,
                          password: password,
                          imageURL: result.data?.imageURL,
                          imageId: result.data?.imageId)
            completion(result)
        }
    }

    func register(login: String,
                  password: String,
                  imageData: Data?,
                  completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
          var result = Result<LoginResponse, NetworkError>()

          guard NetworkReachabilityManager()?.isReachable ?? false else {
              result.error = .networkNotReachable
              completion(result)
              return
          }

          let parameters = ["login": login,
                            "password": password,
                            "apikey": getApiKey()]

          _ = AF.upload(multipartFormData: { multipartFormData in
              for (key, value) in parameters {
                  if let valueData = value.data(using: String.Encoding.utf8) {
                      multipartFormData.append(valueData, withName: key)
                  }
              }

              if let data = imageData {
                  multipartFormData.append(data, withName: "file", fileName: "file.jpg", mimeType: "image/jpg")
              }

             },
          to: "\(getBaseURL())" + "register").responseDecodable(of: [LoginResponse].self) { (response) in
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

                  completion(result)
                  return
              }

              self.saveUser(login: login,
                            password: password,
                            imageURL: result.data?.imageURL,
                            imageId: result.data?.imageId)
              completion(result)
          }
      }

    func setImageUrl(imageUrl: String?) {
        guard let imageUrl = imageUrl else { return }

        UserDefaults.standard.setValue(imageUrl, forKey: Constants.imageURLKey)
    }

    func setUserLogin(login: String?) {
        guard let login = login else { return }

        UserDefaults.standard.setValue(login, forKey: Constants.loginKey)
    }
}
