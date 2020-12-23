import Foundation

struct WardrobeRaw: Decodable {
    let id: Int
    let name: String?
    let wardrobeImage: URL?

    private enum codingKeys: String, CodingKey {
        case id
        case name
        case wardrobeImage
    }
}
