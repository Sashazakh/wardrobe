import Foundation

final class LookInteractor {
	weak var output: LookInteractorOutput?

    private var lookID: Int

    init(lookID: Int) {
        self.lookID = lookID
    }

    private func convertToLookData(model: LookRaw) -> LookData {
        var categories: [String: [ItemData]] = [:]

        model.categories.forEach { categoryName in
            categories[categoryName] = []
        }

        model.items.forEach { item in
            let itemData = ItemData(clothesID: item.clothesID,
                                    category: item.category,
                                    clothesName: item.clothesName,
                                    imageURL: item.imageURL)
            categories[item.category]?.append(itemData)
        }

        return LookData(lookName: model.lookName,
                        categories: categories.map {
                            return CategoryData(categoryName: $0.key,
                                                items: $0.value)
                        })
    }
}

extension LookInteractor: LookInteractorInput {
    func fetchLook() {
        DataService.shared.getAllLookClothes(with: lookID) { [weak self] result in
            guard result.error == nil else {
                guard let networkError = result.error else {
                    return
                }

                switch networkError {
                case .networkNotReachable:
                    self?.output?.showAlert(title: "Ошибка", message: "Не удается подключиться")
                case .lookNotExist:
                    self?.output?.showAlert(title: "Ошибка", message: "Набор не найден")
                default:
                    self?.output?.showAlert(title: "Ошибка", message: "Мы скоро все починим")
                }

                return
            }

            guard let data = result.data,
                  let self = self else {
                return
            }

            self.output?.updateModel(model: self.convertToLookData(model: data))
            self.output?.lookDidReceived()
        }
    }
}
