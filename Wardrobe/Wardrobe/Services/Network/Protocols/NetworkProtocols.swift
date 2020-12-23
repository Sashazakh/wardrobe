import UIKit

protocol AuthServiceInput {
    func createNewAccount(login: String, password: String)

    func login(login: String, password: String, completion: (Result<LoginResponse, Error>) -> Void)
}

protocol DataServiceInput {
    func changeName(newName: String)

    func changePassword(newPassword: Int)

    func changePhoto(newPhoto: UIImage)
    
    func getUserWardrobes(completion: @escaping (Result<WardrobeRaw, Error>) -> Void)
}
