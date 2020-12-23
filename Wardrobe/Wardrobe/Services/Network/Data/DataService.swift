import Alamofire

final class DataService {
    static let shared = DataService()
    
    private init() {
        
    }
}

extension DataService: DataServiceInput {
    
}
