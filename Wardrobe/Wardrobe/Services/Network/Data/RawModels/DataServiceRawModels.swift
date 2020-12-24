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
