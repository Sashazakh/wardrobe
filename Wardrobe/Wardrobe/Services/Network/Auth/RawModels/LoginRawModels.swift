struct LoginResponse: Decodable {
    let login: String

    let userName: String

    let imageURL: String?

    let imageId: Int?

    private enum CodingKeys: String, CodingKey {
        case login = "login"
        case userName = "user_name"
        case imageURL = "image_url"
        case imageId = "image_id"
    }
}
