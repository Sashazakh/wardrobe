import Alamofire

final class DataService: NetworkService {

    static let shared = DataService()

    private override init() {
        super.init()
    }
}

extension DataService: DataServiceInput {

}
