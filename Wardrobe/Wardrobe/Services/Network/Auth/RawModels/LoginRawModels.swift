struct LoginResponse: Decodable {
    let userName: String

    let imageURL: String?

    private enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case imageURL = "image_url"
    }
}
