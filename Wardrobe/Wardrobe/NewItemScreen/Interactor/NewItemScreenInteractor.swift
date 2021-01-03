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
        guard let login = AuthService.shared.getUserLogin() else {
            return
        }

        DataService.shared.newItem(userLogin: login,
                                   name: name,
                                   category: category,
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

            guard let self = self else {
                return
            }

            self.output?.didItemAdded()
        }
    }
}
