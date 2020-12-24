import Alamofire
import UIKit

final class DataService: NetworkService {

    static let shared = DataService()

    private override init() {
        super.init()
    }
}

extension DataService: DataServiceInput {
    // MARK: Settings
    func changeName(newName: String) {

    }

    func changePassword(newPassword: Int) {

    }

    func changePhoto(newPhoto: UIImage) {

    }

    // MARK: Wardrobe

    func getUserWardrobes(completion: @escaping (Result<[WardrobeRaw], NetworkError>) -> Void) {
        let url = getBaseURL() + "getWardrobes?login=Sashazak&apikey=\(getApiKey())"

        let request = AF.request(url)

        var result = Result<[WardrobeRaw], NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        request.responseDecodable(of: [WardrobeRaw].self) { response in
            switch response.result {
            case .success(let wardrobe):
                result.data = wardrobe
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

    func addWardrobe(name: String, description: String, image: UIImage) {

    }

    // MARK: Wardrobe detail

    func getWardrobeId(with id: Int) {

    }

    // Думаем здесь принимать словарь вещей
    func addClothesToLook() {

    }

    // MARK: Look screen

    func getAllLookClothes(with id: Int) {

    }

    func deleItemFormLook(with id: Int) {

    }

    func createLook() {

    }

    // Словарь новых значений
    func deleteClothesFromLook(with id: [Int]) {

    }

    // MARK: Wardrobe users

    func getAllUsers(with wardrobeId: Int) {

    }

    func addUserToWardrobe(with login: String) {

    }

    func deleteUserFromWardrobe(with login: String) {

    }

    // MARK: Clothes

    // Можно передавать модель вещи
    func newItem() {

    }

    func getAllitems() {

    }

    func deleteItem(with id: Int) {
    }
}
