import Foundation

final class NewItemScreenInteractor {
	weak var output: NewItemScreenInteractorOutput?

    private var category: String

    init(category: String) {
        self.category = category
    }
}

extension NewItemScreenInteractor: NewItemScreenInteractorInput {
    func addItem(name: String, imageData: Data?) {

    }
}
