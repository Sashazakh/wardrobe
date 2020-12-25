import UIKit

protocol AuthServiceInput {
    func register(login: String,
                  fio: String,
                  password: String,
                  imageData: Data?,
                  completion: @escaping (Result<LoginResponse, NetworkError>) -> Void)

    func login(login: String,
               password: String,
               completion: @escaping (Result<LoginResponse, NetworkError>) -> Void)
}

protocol DataServiceInput {
    func getUserWardrobes(completion: @escaping (Result<[WardrobeRaw], NetworkError>) -> Void)
}
