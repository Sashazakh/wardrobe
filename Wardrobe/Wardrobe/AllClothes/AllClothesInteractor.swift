import Foundation

final class AllClothesInteractor {
	weak var output: AllClothesInteractorOutput?

    private func translateRawDataToAllClothesModel(data: AllItemsRaw) -> AllClothesModel {
        var categories: [String: [ItemData]] = [:]
        for category in data.categories {
            categories[category] = []
        }

        data.clothes.forEach { item in
            let clothing = ItemData(with: item)
            categories[clothing.category]?.append(clothing)
        }

        return AllClothesModel(categories: categories.map {
            return CategoryData(categoryName: $0.key,
                                items: $0.value)
        })
    }
}

extension AllClothesInteractor: AllClothesInteractorInput {
    func getAllClothes() {
        guard let login = AuthService.shared.getUserLogin() else {
            return
        }

        DataService.shared.getAllItems(for: login) { [weak self] (result) in
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

            guard let data = result.data,
                    let self = self else {
                return
            }

            let models = self.translateRawDataToAllClothesModel(data: data)
            self.output?.handleModel(model: models)
            // self.allUserItems = self.convertToAllItemsData(model: data.clothes)
            // self.fetchLook(lookID: self.lookID)
        }
    }
}
