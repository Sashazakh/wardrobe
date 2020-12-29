import Foundation

final class CreateLookInteractor {
	weak var output: CreateLookInteractorOutput?

    private func convertToAllItemsData(model: [ItemRaw]) -> AllItemsData {
        var uniqueCategories: [String: [ItemData]] = [:]

        model.forEach { item in
            if uniqueCategories[item.category] == nil {
                uniqueCategories[item.category] = [ItemData(clothesID: item.clothesID,
                                                            category: item.category,
                                                            clothesName: item.clothesName,
                                                            imageURL: item.imageURL)]
            } else {
                uniqueCategories[item.category]?.append(ItemData(clothesID: item.clothesID,
                                                                 category: item.category,
                                                                 clothesName: item.clothesName,
                                                                 imageURL: item.imageURL))
            }
        }

        return AllItemsData(categories: uniqueCategories.map { cortege in
            return CategoryData(categoryName: cortege.key, items: cortege.value)
        })
    }
}

extension CreateLookInteractor: CreateLookInteractorInput {
    func fetchAllItems() {
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

            self.output?.updateModel(model: self.convertToAllItemsData(model: data.clothes))
            self.output?.allItemsSuccesfullyReceived()
        }
    }
}
