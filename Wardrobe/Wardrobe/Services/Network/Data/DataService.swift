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

    func getUserWardrobes(for user: String, completion: @escaping (Result<[WardrobeRaw], NetworkError>) -> Void) {

        let url = getBaseURL() + "getWardrobes?login=\(user)&apikey=\(getApiKey())"

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

    func addWardrobe(login: String,
                     name: String,
                     description: String,
                     imageData: Data?,
                     completion: @escaping (SingleResult<NetworkError>) -> Void) {
        let parameters: [String: String] = [
            "login": "\(login)",
            "wardrobe_name": "\(name)",
            "wardrobe_description": "\(description)",
            "apikey": "\(getApiKey())"
        ]

        let url = getBaseURL() + "createWardrobe"
        var result = SingleResult<NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        _ = AF.upload(multipartFormData: { multipartFormData in
            if let data = imageData {
                multipartFormData.append(data, withName: "file", fileName: "file.jpg", mimeType: "image/jpg")
            }
                for (key, value) in parameters {
                     if let valueData = value.data(using: String.Encoding.utf8) {
                         multipartFormData.append(valueData, withName: key)
                     }
                }
        }, to: url).response(completionHandler: { (response) in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {
                    result.error = .unknownError
                    completion(result)
                    return
                }

                switch statusCode {
                case ResponseCode.success.code:
                    completion(result)
                case ResponseCode.error.code:
                    result.error = .networkNotReachable
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
        })
    }

    // MARK: Wardrobe detail

    func getWardrobeId(with id: Int) {

    }

    // Думаем здесь принимать словарь вещей
    func addClothesToLook() {

    }

    // MARK: Look screen

    func getAllLookClothes(with id: Int, completion: @escaping (Result<LookRaw, NetworkError>) -> Void) {
        let request = AF.request(getBaseURL() + "getLook?" + "look_id=\(id)" + "&apikey=\(getApiKey())")
        var result = Result<LookRaw, NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        request.responseDecodable(of: [LookRaw].self) { (response) in
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
                    result.error = .lookNotExist
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

    func deleItemFormLook(with id: Int) {

    }

    func createLook(wardrobeID: Int,
                    name: String,
                    imageData: Data?,
                    choosedItems: [Int],
                    completion: @escaping (SingleResult<NetworkError>) -> Void) {
        var result = SingleResult<NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        let parameters: [String: String] = [
            "look_name": name,
            "wardrobe_id": "\(wardrobeID)",
            "items_ids": "\(choosedItems)",
            "apikey": "\(getApiKey())"
        ]

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
        to: "\(getBaseURL())" + "createLook").response { (response) in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {
                    result.error = .unknownError
                    completion(result)
                    return
                }

                switch statusCode {
                case ResponseCode.success.code:
                    ()
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
            }

            completion(result)
        }
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

    func getAllItems(for login: String, completion: @escaping (Result<AllItemsRaw, NetworkError>) -> Void) {
        let request = AF.request(getBaseURL() + "getAllItems?login=\(login)&apikey=\(getApiKey())")
        var result = Result<AllItemsRaw, NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        request.responseDecodable(of: [AllItemsRaw].self) { (response) in
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
                    result.error = .itemsNotExist
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

    func deleteItem(with id: Int) {
    }
}
