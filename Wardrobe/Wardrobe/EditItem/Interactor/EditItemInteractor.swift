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

    func saveItemChanges(name: String, imageData: Data?) {
        var newName: String?

        if name != model.name {
            newName = name
        }

        if newName == nil && imageData == nil {
            return
        }

        DataService.shared.updateItem(id: model.itemID,
                                      name: newName,
                                      imageData: imageData) { [weak self] result in
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

            guard let self = self,
                  let newName = newName else {
                return
            }

            self.model.name = newName
            self.output?.didSavedItemData()
        }
    }
}
