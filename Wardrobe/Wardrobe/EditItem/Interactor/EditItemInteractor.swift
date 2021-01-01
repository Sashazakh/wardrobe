import Foundation

final class EditItemInteractor {
	weak var output: EditItemInteractorOutput?

    private var model: EditItemInteractorData

    init(itemID: Int) {
        self.model = EditItemInteractorData(itemID: itemID,
                                            name: nil,
                                            imageURL: nil)
    }
}

extension EditItemInteractor: EditItemInteractorInput {
    func fetchItem() {
        DataService.shared.getItem(id: model.itemID) { [weak self] result in
            guard result.error == nil else {
                guard let networkError = result.error else {
                    return
                }

                switch networkError {
                case .networkNotReachable:
                    self?.output?.showAlert(title: "Ошибка", message: "Не удается подключиться")
                default:
                    self?.output?.showAlert(title: "Ошибка", message: "Мы скоро все починим")
                }

                return
            }

            guard let data = result.data,
                  let self = self else {
                return
            }

            self.model.name = data.clothesName
            self.model.imageURL = data.imageURL
            self.output?.updateModel(model: EditItemPresenterData(model: self.model))
            self.output?.didReceivedItemData()
        }
    }
}
