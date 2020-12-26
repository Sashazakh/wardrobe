import Foundation

struct WardrobeRaw: Decodable {
    let wardrobeDescription: String?
    let imageUrl: String?
    let name: String?
    let wardrobeOwner: String?

    private enum CodingKeys: String, CodingKey {
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
