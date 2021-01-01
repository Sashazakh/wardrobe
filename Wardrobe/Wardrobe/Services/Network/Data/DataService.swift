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
    func changeName(newName: String,
                    completion: @escaping (SingleResult<NetworkError>) -> Void) {
        guard let login = getUserLogin() else { return }

        let parametrs: [String: String] =
            ["login": login,
             "new_name": newName,
             "apikey": getApiKey()]

        let url = getBaseURL() + "changeName"

        var result = SingleResult<NetworkError>()
        let request = AF.request(url, method: .post, parameters: parametrs)

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        request.response { response in
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
        }
    }

    func changePassword(newPassword: Int) {

    }

    func changePhoto(newPhotoData: Data,
                     completion: @escaping (SingleResult<NetworkError>) -> Void) {
        let parameters: [String: String] = [
            "login": "\(String(describing: getlogin()))"
        ]

        var result = SingleResult<NetworkError>()
        let url = "jopa"

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        _ = AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(newPhotoData, withName: "file", fileName: "file.jpg", mimeType: "image/jpg")
                for (key, value) in parameters {
                     if let valueData = value.data(using: String.Encoding.utf8) {
                         multipartFormData.append(valueData, withName: key)
                     }
                }
        },
        to: url).response(completionHandler: { (response) in
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
            completion(result)
        })
    }

    // MARK: Wardrobe

    func getUserWardrobes(for user: String,
                          completion: @escaping (Result<[WardrobeRaw], NetworkError>) -> Void) {

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

                completion(result)
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

    func getAllLookClothes(with id: Int,
                           completion: @escaping (Result<LookRaw, NetworkError>) -> Void) {
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

    func deleteItemFromLook(lookID: Int,
                            itemID: Int,
                            completion: @escaping (SingleResult<NetworkError>) -> Void) {
        var result = SingleResult<NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        let request = AF.request("\(getBaseURL())" + "deleteItemFromLook?look_id=\(lookID)&item_id=\(itemID)&apikey=\(getApiKey())")

        request.response { (response) in
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

                completion(result)
            }
        }
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

    func updateLook(lookID: Int,
                    itemIDs: [Int],
                    completion: @escaping (SingleResult<NetworkError>) -> Void) {
        var result = SingleResult<NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        let parameters: [String: String] = [
            "items_ids": "(itemIDs)",
            "look_id": "(lookID)",
            "apikey": "(getApiKey())"
        ]

        let request = AF.request("(getBaseURL())" + "updateLookItems", method: .post, parameters: parameters)

        request.response { (response) in
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
                completion(result)
            }
        }
    }

    func getLooks(for wardrobeId: Int,
                  completion: @escaping (Result<[WardrobeDetailLookRaw], NetworkError>) -> Void) {
        let request = AF.request(getBaseURL() + "getLookByWardrobe?" + "wardrobe_id=\(wardrobeId)" + "&apikey=\(getApiKey())")
        var result = Result<[WardrobeDetailLookRaw], NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        request.responseDecodable(of: [WardrobeDetailLookRaw].self) { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    result.error = .unknownError
                    completion(result)
                    return
                }

                switch statusCode {
                case ResponseCode.success.code:
                    result.data = data
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

    // Словарь новых значений
    func deleteClothesFromLook(with id: [Int]) {

    }

    // MARK: Wardrobe users

    func getWardroeUsers(with wardrobeId: Int,
                         completion: @escaping (Result<[WardrobeUserRaw], NetworkError>) -> Void) {
        let url = getBaseURL() + "getWardrobeUsers"
        + "?wardrobe_id=" + "\(wardrobeId)"
        + "&apikey=\(getApiKey())"

        var result = Result<[WardrobeUserRaw], NetworkError>()

        let request = AF.request(url)
        request.responseDecodable(of: [WardrobeUserRaw].self) { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    result.error = .unknownError
                    completion(result)
                    return
                }

                switch statusCode {
                case ResponseCode.success.code:
                    result.data = data
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

    func addUserToWardrobe(with login: String,
                           wardobeId: Int,
                           completion: @escaping (SingleResult<NetworkError>) -> Void) {
        guard let userLogin = getUserLogin() else { return }
        let url = getBaseURL() + "sendInvite" +
            "?my_login=\(userLogin)" +
            "&login_to_invite=\(login)" +
            "&wardrobe_id=\(wardobeId)" +
            "&apikey=\(getApiKey())"

        var result = SingleResult<NetworkError>()

        let request = AF.request(url)
        request.response { response in
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
        }
    }
    func deleteUserFromWardrobe(with login: String) {

    }

    func wardrobeResponseInvite(inviteId: Int,
                                response: InviteWardrobeResponse,
                                completion: @escaping (SingleResult<NetworkError>) -> Void) {
        let url = getBaseURL() + "handleInvite"
        + "?inviteId=\(inviteId)"
        + "&accepted=\(response.rawValue)"
        + "&apikey=\(getApiKey())"

        var result = SingleResult<NetworkError>()

        let request = AF.request(url)

        request.response { response in
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
        }
    }

    func getUserInvites(completion: @escaping (Result<[InviteRaw], NetworkError>) -> Void) {
        guard let login = getUserLogin() else { return }
        let url = getBaseURL() +
            "whoInvitesMe" +
            "?login=\(login)&apikey=\(getApiKey())"
        let request = AF.request(url)
        var result = Result<[InviteRaw], NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        request.responseDecodable(of: [InviteRaw].self) { response in
            switch response.result {
            case .success(let invites):
                result.data = invites
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
    // MARK: Clothes

    // Можно передавать модель вещи
    func newItem() {

    }

    func getAllItems(for login: String,
                     completion: @escaping (Result<AllItemsRaw, NetworkError>) -> Void) {
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

    func getItem(id: Int,
                 completion: @escaping (Result<EditItemRaw, NetworkError>) -> Void) {
        let request = AF.request(getBaseURL() + "getItemById?item_id=\(id)&apikey=\(getApiKey())")
        var result = Result<EditItemRaw, NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        request.responseDecodable(of: [EditItemRaw].self) { (response) in
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

    func getUserLogin() -> String? {
        return UserDefaults.standard.string(forKey: Constants.loginKey)
    }

    func setNewUserName(newName: String) {
        UserDefaults.standard.setValue(newName, forKey: Constants.userNameKey)
    }
}

struct Constants {
    static let authKey: String = "isAuthorized"

    static let loginKey: String = "login"

    static let userNameKey: String = "username"

    static let passwordKey: String = "password"

    static let imageURLKey: String = "imageURL"
}
