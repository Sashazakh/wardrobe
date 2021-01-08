struct LoginResponse: Decodable {
    let login: String

    let imageURL: String?

    let imageId: Int?

    private enum CodingKeys: String, CodingKey {
        case login = "login"
        case imageURL = "image_url"
        case imageId = "image_id"
    }
}
