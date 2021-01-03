import Foundation

struct EditLookPresenterData {
    var name: String

    var imageURL: String?

    init(model: EditLookInteractorData) {
        self.name = model.name ?? "Default"
        self.imageURL = model.imageURL
    }
}

struct EditLookInteractorData {
    var lookID: Int

    var name: String?

    var imageURL: String?
}
