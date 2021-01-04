enum NetworkError: Error {
    case networkNotReachable

    case connectionToServerError

    case userNotExist

    case userAlreadyExist

    case lookNotExist

    case itemsNotExist

    case unknownError

    case userAlreadyInvite
}

extension NetworkError {
    var type: String {
        switch self {
        case .networkNotReachable:
            return ErrorDescription.networkNotReachable
        case .connectionToServerError:
            return ErrorDescription.connectionToServerError
        case .userNotExist:
            return ErrorDescription.userNotExist
        case .userAlreadyExist:
            return ErrorDescription.userAlreadyExist
        case .lookNotExist:
            return ErrorDescription.lookNotExist
        case .itemsNotExist:
            return ErrorDescription.itemsNotExist
        case .unknownError:
            return ErrorDescription.unknownError
        case .userAlreadyInvite:
            return ErrorDescription.userAlreadyInWardrobe
        }
    }
}

extension NetworkError {
    private struct ErrorDescription {
        static let networkNotReachable: String = "User has no network"

        static let connectionToServerError: String = "Server not reachable"

        static let userNotExist: String = "User not exist"

        static let userAlreadyExist: String = "User already exist"

        static let lookNotExist: String = "No such look"

        static let itemsNotExist: String = "No items"

        static let unknownError: String = "UnknownError"

        static let userAlreadyInWardrobe: String = "User already in wardrobe"
    }
}
