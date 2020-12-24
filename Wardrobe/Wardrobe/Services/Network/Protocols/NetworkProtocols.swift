import UIKit

protocol AuthServiceInput {
    func createNewAccount(login: String, password: String)

    func login(login: String, password: String, completion: (Result<LoginResponse, Error>) -> Void)
}

protocol DataServiceInput {
    func getUserWardrobes(completion: @escaping (Result<[WardrobeRaw], Error>) -> Void)
}
