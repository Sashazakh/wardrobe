import Foundation

final class EditWardrobeInteractor {
	weak var output: EditWardrobeInteractorOutput?

    private var wardrobeID: Int

    init(wardrobeID: Int) {
        self.wardrobeID = wardrobeID
    }
}

extension EditWardrobeInteractor: EditWardrobeInteractorInput {
}
