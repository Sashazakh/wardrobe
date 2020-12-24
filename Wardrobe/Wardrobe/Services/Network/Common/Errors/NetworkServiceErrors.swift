enum NetworkError: Error {
    case networkNotReachable

    case connectionToServerError

    case userNotExist

    case userAlreadyExist

    case unknownError
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
        case .unknownError:
            return ErrorDescription.unknownError
        }
    }
}

extension NetworkError {
    private struct ErrorDescription {
        static let networkNotReachable: String = "User has no network"

        static let connectionToServerError: String = "Server not reachable"

        static let userNotExist: String = "User not exist"

        static let userAlreadyExist: String = "User already exist"

        static let unknownError: String = "UnknownError"
    }
}
