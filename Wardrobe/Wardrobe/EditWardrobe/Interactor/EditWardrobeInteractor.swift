import Foundation

final class EditWardrobeInteractor {
    weak var output: EditWardrobeInteractorOutput?

    private var model: EditWardrobeInteractorData

    init(wardrobeID: Int) {
        self.model = EditWardrobeInteractorData(wardrobeID: wardrobeID,
                                                name: nil,
                                                imageURL: nil)
    }
}

extension EditWardrobeInteractor: EditWardrobeInteractorInput {
    func fetchWardrobeData() {
        DataService.shared.getWardrobeMetadata(wardrobeID: model.wardrobeID) { [weak self] result in
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

            self.model.name = data.name
            self.model.imageURL = data.imageURL
            self.output?.updateModel(model: EditWardrobePresenterData(model: self.model))
            self.output?.didReceivedWardrobeData()
        }
    }

    func saveWardrobeDataChanges(name: String, imageData: Data?) {
        var newName: String?

        if name != model.name {
            newName = name
        }

        if newName == nil && imageData == nil {
            return
        }

        DataService.shared.updateWardrobeMetadata(wardrobeID: model.wardrobeID,
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

            guard let self = self else { return }

            self.model.name = newName
            self.output?.didSavedWardrobeData()
        }
    }
}
