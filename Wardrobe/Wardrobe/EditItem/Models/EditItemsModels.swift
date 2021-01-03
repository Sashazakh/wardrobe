import Foundation

struct EditItemPresenterData {
    var name: String

    var imageURL: String?

    init(model: EditItemInteractorData) {
        self.name = model.name ?? "Default"
        self.imageURL = model.imageURL
    }
}

struct EditItemInteractorData {
    var itemID: Int

    var name: String?

    var imageURL: String?
}
