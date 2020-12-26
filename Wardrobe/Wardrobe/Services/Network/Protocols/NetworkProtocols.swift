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

    func isAuthorized(completion: @escaping (Result<Bool, NetworkError>) -> Void)

    func getUserLogin() -> String?

    func getUserName() -> String?

    func getUserImageURL() -> String?
}

protocol DataServiceInput {
    func getUserWardrobes(for user: String, completion: @escaping (Result<[WardrobeRaw], NetworkError>) -> Void)

    func getAllLookClothes(with id: Int, completion: @escaping (Result<LookRaw, NetworkError>) -> Void)
}
