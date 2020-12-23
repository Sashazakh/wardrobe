import Alamofire

final class AuthService {
    static let shared = AuthService()
    
    private init() {
        
    }
}

extension AuthService: AuthServiceInput {
    
}
