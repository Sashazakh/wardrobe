import Foundation

final class EditLookInteractor {
    weak var output: EditLookInteractorOutput?

    private var model: EditLookInteractorData

    init(lookID: Int) {
        self.model = EditLookInteractorData(lookID: lookID,
                                            name: nil,
                                            imageURL: nil)
    }
}

extension EditLookInteractor: EditLookInteractorInput {
    func fetchLookData() {
        DataService.shared.getLookMetadata(lookID: model.lookID) { [weak self] result in
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
            self.output?.updateModel(model: EditLookPresenterData(model: self.model))
            self.output?.didReceivedLookData()
        }
    }

    func saveLookDataChanges(name: String, imageData: Data?) {
        var newName: String?

        if name != model.name {
            newName = name
        }

        if newName == nil && imageData == nil {
            return
        }

        DataService.shared.updateLookMetadata(lookID: model.lookID,
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
            self.output?.didSavedLookData()
        }
    }
}
