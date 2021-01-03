import Foundation

final class EditLookInteractor {
	weak var output: EditLookInteractorOutput?

    private var lookID: Int

    init(lookID: Int) {
        self.lookID = lookID
    }
}

extension EditLookInteractor: EditLookInteractorInput {
}
