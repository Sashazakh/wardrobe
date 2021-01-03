import Foundation

final class SetupLookInteractor {
	weak var output: SetupLookInteractorOutput?

    private var itemIDs: [Int]

    private var wardrobeID: Int

    init(wardrobeID: Int, itemIDs: [Int]) {
        self.itemIDs = itemIDs
        self.wardrobeID = wardrobeID
    }
}

extension SetupLookInteractor: SetupLookInteractorInput {
    func createLook(name: String, imageData: Data?) {
        DataService.shared.createLook(wardrobeID: wardrobeID,
                                      name: name,
                                      imageData: imageData,
                                      choosedItems: itemIDs) { [weak self] result in
            guard result.error == nil else {
                guard let networkError = result.error else {
                    return
                }

                switch networkError {
                case .networkNotReachable:
                    self?.output?.showAlert(title: "Ошибка", message: "Не удается подключиться")
                case .itemsNotExist:
                    self?.output?.showAlert(title: "Ошибка", message: "Вещи не найдены")
                default:
                    self?.output?.showAlert(title: "Ошибка", message: "Мы скоро все починим")
                }

                return
            }

            guard let self = self else {
                return
            }

            self.output?.lookDidSaved()
        }
    }
}
