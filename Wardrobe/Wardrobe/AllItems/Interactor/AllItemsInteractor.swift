import Foundation

final class AllItemsInteractor {
	weak var output: AllItemsInteractorOutput?

    private var lookID: Int

    private var allUserItems: AllItemsData?

    private var look: LookData?

    private var ownerLogin: String

    init(lookID: Int, ownerLogin: String) {
        self.lookID = lookID
        self.ownerLogin = ownerLogin
    }

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

        var categoriesArray: [(String, [ItemData])] = uniqueCategories.map {
            return ($0.key, $0.value)
        }

        categoriesArray.sort {
            $0.0 < $1.0
        }

        return AllItemsData(categories: categoriesArray.map { cortege in
            return CategoryData(categoryName: cortege.0, items: cortege.1)
        })
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

    private func filterItems() {
        guard var allItems = allUserItems,
              let lookItems = look else {
            return
        }

        var uniqueClothIDs: Set<Int> = []

        for i in .zero..<lookItems.categories.count {
            for j in .zero..<lookItems.categories[i].items.count {
                uniqueClothIDs.insert(lookItems.categories[i].items[j].clothesID)
            }
        }

        for i in .zero..<allItems.categories.count {
            allItems.categories[i].items = allItems.categories[i].items.filter { item in
                return !uniqueClothIDs.contains(item.clothesID)
            }
        }

        allItems.categories = allItems.categories.filter { category in
            return category.items.count > .zero
        }

        output?.updateModel(model: allItems)
        output?.userItemsDidReceived()
    }

    private func fetchLook(lookID: Int) {
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

            self.look = self.convertToLookData(model: data)
            self.filterItems()
        }
    }
}

extension AllItemsInteractor: AllItemsInteractorInput {
    func fetchUserItems() {
        DataService.shared.getAllItems(for: ownerLogin) { [weak self] (result) in
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

            self.allUserItems = self.convertToAllItemsData(model: data.clothes)
            self.fetchLook(lookID: self.lookID)
        }
    }

}
