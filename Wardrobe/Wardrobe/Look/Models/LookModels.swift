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

extension ItemData {
    init(with data: ItemRaw) {
        self.clothesID = data.clothesID
        self.category = data.category
        self.clothesName = data.clothesName
        self.imageURL = data.imageURL
    }
}
