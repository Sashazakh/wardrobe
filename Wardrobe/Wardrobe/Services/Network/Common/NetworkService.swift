import Alamofire

class NetworkService {

    private var apiKey: String?

    private var baseURL: String?

    init() {
        setApiKey()
        setBaseURL()
    }

    private func setApiKey() {
        guard let filePath = Bundle.main.path(forResource: Constants.securePlistFilename, ofType: "plist") else {
            apiKey = nil
            return
        }

        let plist = NSDictionary(contentsOfFile: filePath)

        guard let value = plist?.object(forKey: Constants.apiKey) as? String else {
            apiKey = nil
            return
        }

        apiKey = value
    }

    private func setBaseURL() {
        guard let filePath = Bundle.main.path(forResource: Constants.commonPlistFilename, ofType: "plist") else {
            baseURL = nil
            return
        }

        let plist = NSDictionary(contentsOfFile: filePath)

        guard let value = plist?.object(forKey: Constants.baseURL) as? String else {
            baseURL = nil
            return
        }

        baseURL = value
    }

    func getApiKey() -> String {
        return apiKey ?? Constants.suckBigBlackMambaDick
    }

    func getBaseURL() -> String {
        return baseURL ?? Constants.suckBigBlackMambaDick
    }
}

extension NetworkService {
    private struct Constants {
        static let securePlistFilename: String = "Wardrobe-Info"

        static let commonPlistFilename: String = "Info"

        static let apiKey: String = "API_KEY"

        static let baseURL: String = "PROD_HOST"

        static let suckBigBlackMambaDick: String = "blowjob"
    }
}

enum ResponseCode {
    case success
    case error
}

extension ResponseCode {
    var code: Int {
        switch self {
        case .success:
            return Codes.successCode
        case .error:
            return Codes.errorCode
        }
    }
}

extension ResponseCode {
    private struct Codes {
        static let successCode: Int = 200

        static let errorCode: Int = 404
    }
}
