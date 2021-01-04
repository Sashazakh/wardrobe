import Foundation

struct EditWardrobePresenterData {
    var name: String

    var imageURL: String?

    init(model: EditWardrobeInteractorData) {
        self.name = model.name ?? "Default"
        self.imageURL = model.imageURL
    }
}

struct EditWardrobeInteractorData {
    var wardrobeID: Int

    var name: String?

    var imageURL: String?
}
