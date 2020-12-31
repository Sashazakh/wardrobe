import Foundation

struct WardrobeRaw: Decodable {
    let id: Int
    let wardrobeDescription: String?
    let imageUrl: String?
    let name: String?
    let wardrobeOwner: String?

    private enum CodingKeys: String, CodingKey {
        case id = "wardrobe_id"
        case wardrobeDescription = "wardrobe_description"
        case imageUrl = "wardrobe_image"
        case name = "wardrobe_name"
        case wardrobeOwner = "wardrobe_owner"
    }
}

struct LookRaw: Decodable {
    let lookID: Int
    let lookName: String
    let categories: [String]
    let items: [ItemRaw]

    private enum CodingKeys: String, CodingKey {
        case lookID = "look_id"
        case lookName = "look_name"
        case categories = "categories"
        case items = "items"
    }
}

struct ItemRaw: Decodable {
    let clothesID: Int
    let category: String
    let clothesName: String
    let imageURL: String?

    private enum CodingKeys: String, CodingKey {
        case clothesID = "clothes_id"
        case category = "category"
        case clothesName = "clothes_name"
        case imageURL = "image_url"
    }
}

struct AllItemsRaw: Decodable {
    let categories: [String]
    let clothes: [ItemRaw]
}

struct InviteRaw: Decodable {
    let inviteId: Int
    let login: String
    let wardrobeName: String
    let imageUrl: String?

    private enum CodingKeys: String, CodingKey {
        case inviteId = "invite_id"
        case login = "login_that_invites"
        case wardrobeName = "wardrobe_name"
        case imageUrl = "image_url"
    }
}

struct WardrobeDetailLookRaw: Decodable {
    let id: Int
    let name: String
    let imageUrl: String?
    let imageId: Int?

    private enum CodingKeys: String, CodingKey {
        case id = "look_id"
        case name = "look_name"
        case imageUrl = "image_url"
        case imageId = "image_id"
    }
}

struct WardrobeUserRaw: Decodable {
    let login: String
    let userName: String
    let imageUrl: String?
    let imageId: Int?

    private enum CodingKeys: String, CodingKey {
        case login = "login"
        case userName = "user_name"
        case imageUrl = "image_url"
        case imageId = "image_id"
    }
}
