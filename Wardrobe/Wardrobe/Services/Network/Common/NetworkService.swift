import Alamofire

class NetworkService {

    private var apiKey: String?

    init() {
        setApiKey()
    }

    private func setApiKey() {
        guard let filePath = Bundle.main.path(forResource: Constants.plistFilename, ofType: "plist") else {
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

    func getApiKey() -> String {
        return apiKey ?? Constants.suckBigBlackMambaDick
    }
}

extension NetworkService {
    private struct Constants {
        static let plistFilename: String = "Wardrobe-Info"

        static let apiKey: String = "API_KEY"

        static let suckBigBlackMambaDick: String = "blowjob"
    }
}
