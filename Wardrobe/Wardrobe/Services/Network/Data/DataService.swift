import Alamofire
import Kingfisher

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

    func changePhoto(newPhotoData: Data,
                     completion: @escaping (Result<ResponseEditString, NetworkError>) -> Void) {
        guard let user = getUserLogin() else { return }

        let parameters: [String: String] = [
            "login": "\(user)",
            "apikey": getApiKey()
        ]

        var result = Result<ResponseEditString, NetworkError>()
        let url = getBaseURL() + "changeAvatar"

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
        to: url).responseDecodable(of: [ResponseEditString].self) { response in
            switch response.result {
            case .success(let url):
                result.data = url.first
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

    // MARK: Wardrobe

    func getUserWardrobes(completion: @escaping (Result<[WardrobeRaw], NetworkError>) -> Void) {

        guard let login = getUserLogin() else { return }
        let url = getBaseURL() + "getWardrobes?login=\(login)&apikey=\(getApiKey())"

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

    func deleteWardrobe(with id: Int,
                        completion: @escaping (SingleResult<NetworkError>) -> Void) {
        guard let login = getUserLogin() else { return }
        let url = getBaseURL()
            + "deleteWardrobe?wardrobe_id=\(id)&apikey=\(getApiKey())&login=\(login)"

        var result = SingleResult<NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

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

    // MARK: Wardrobe detail

    func getLookMetadata(lookID: Int,
                         completion: @escaping (Result<LookMetadataRaw, NetworkError>) -> Void) {
        let request = AF.request(getBaseURL() + "getLookById?" + "look_id=\(lookID)" + "&apikey=\(getApiKey())")
        var result = Result<LookMetadataRaw, NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        request.responseDecodable(of: [LookMetadataRaw].self) { (response) in
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

                completion(result)
            }

            completion(result)
        }
    }

    func updateLookMetadata(lookID: Int,
                            name: String?,
                            imageData: Data?,
                            completion: @escaping (SingleResult<NetworkError>) -> Void) {
        var result = SingleResult<NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        let parameters: [String: String] = [
            "look_id": "\(lookID)",
            "apikey": "\(getApiKey())"
        ]

        _ = AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let valueData = value.data(using: String.Encoding.utf8) {
                    multipartFormData.append(valueData, withName: key)
                }
            }

            if let newName = name,
               let nameData = newName.data(using: String.Encoding.utf8) {
                multipartFormData.append(nameData, withName: "new_name")
            }

            if let data = imageData {
                multipartFormData.append(data, withName: "file", fileName: "file.jpg", mimeType: "image/jpg")
            }
        }, to: getBaseURL() + "updateLook").response { (response) in
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

    func getWardrobeMetadata(wardrobeID: Int,
                             completion: @escaping (Result<WardrobeMetadataRaw, NetworkError>) -> Void) {
        let request = AF.request(getBaseURL() + "getWardrobeById?" + "wardrobe_id=\(wardrobeID)" + "&apikey=\(getApiKey())")
        var result = Result<WardrobeMetadataRaw, NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        request.responseDecodable(of: [WardrobeMetadataRaw].self) { (response) in
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

                completion(result)
            }

            completion(result)
        }

    }

    func updateWardrobeMetadata(wardrobeID: Int,
                                name: String?,
                                imageData: Data?,
                                completion: @escaping (SingleResult<NetworkError>) -> Void) {
        var result = SingleResult<NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        let parameters: [String: String] = [
            "wardrobe_id": "\(wardrobeID)",
            "apikey": "\(getApiKey())"
        ]

        _ = AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let valueData = value.data(using: String.Encoding.utf8) {
                    multipartFormData.append(valueData, withName: key)
                }
            }

            if let newName = name,
               let nameData = newName.data(using: String.Encoding.utf8) {
                multipartFormData.append(nameData, withName: "new_name")
            }

            if let data = imageData {
                multipartFormData.append(data, withName: "file", fileName: "file.jpg", mimeType: "image/jpg")
            }
        }, to: getBaseURL() + "updateWardrobe").response { (response) in
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

    func deleteLook(lookId: Int,
                    completion: @escaping (SingleResult<NetworkError>) -> Void) {
        let url = getBaseURL() + "removeLook?look_id=\(lookId)&apikey=\(getApiKey())"

        var result = SingleResult<NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

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
            "items_ids": "\(itemIDs)",
            "look_id": "\(lookID)",
            "apikey": "\(getApiKey())"
        ]

        let request = AF.request("\(getBaseURL())" + "updateLookItems", method: .post, parameters: parameters)

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
                case ResponseCode.userAlreadyInvite.code:
                    result.error = .userAlreadyInvite
                    completion(result)
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

    func deleteUserFromWardrobe(wardrobeId: Int,
                                login: String,
                                completion: @escaping (SingleResult<NetworkError>) -> Void) {
        let url = getBaseURL() + "removeUserFromWardrobe"
        + "?wardrobe_id=\(wardrobeId)"
        + "&remove_login=\(login)"
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
                    result.error = .deletingOwner
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

    func newItem(userLogin: String,
                 name: String,
                 category: String,
                 imageData: Data?,
                 completion: @escaping (SingleResult<NetworkError>) -> Void) {
        var result = SingleResult<NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        let parameters: [String: String] = [
            "new_name": "\(name)",
            "login": "\(userLogin)",
            "type": "\(category)",
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
        }, to: getBaseURL() + "addItem").response { (response) in
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

    func updateItem(id: Int,
                    name: String?,
                    imageData: Data?,
                    completion: @escaping (SingleResult<NetworkError>) -> Void) {
        var result = SingleResult<NetworkError>()

        guard NetworkReachabilityManager()?.isReachable ?? false else {
            result.error = .networkNotReachable
            completion(result)
            return
        }

        let parameters: [String: String] = [
            "item_id": "\(id)",
            "apikey": "\(getApiKey())"
        ]

        _ = AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let valueData = value.data(using: String.Encoding.utf8) {
                    multipartFormData.append(valueData, withName: key)
                }
            }

            if let newName = name,
               let nameData = newName.data(using: String.Encoding.utf8) {
                multipartFormData.append(nameData, withName: "new_name")
            }

            if let data = imageData {
                multipartFormData.append(data, withName: "file", fileName: "file.jpg", mimeType: "image/jpg")
            }
        }, to: getBaseURL() + "updateItem").response { (response) in
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

    func removeItem(id: Int,
                    completion: @escaping (SingleResult<NetworkError>) -> Void) {
        let request = AF.request(getBaseURL() + "removeItem?item_id=\(id)&apikey=\(getApiKey())")
        var result = SingleResult<NetworkError>()

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

    func setNewUserName(newName: String) {
        UserDefaults.standard.setValue(newName, forKey: Constants.userNameKey)
    }

    func cleanCache() {
        ImageCache.default.clearCache()
    }
}
