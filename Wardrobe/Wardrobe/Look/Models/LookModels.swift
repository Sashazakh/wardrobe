struct LookData {
    var lookName: String

    var categories: [CategoryData]
}

struct CategoryData {
    var categoryName: String

    var items: [ItemData]
}

struct ItemData {
    let clothesID: Int

    let category: String

    let clothesName: String

    let imageURL: String?
}
