import Foundation

final class LookInteractor {
	weak var output: LookInteractorOutput?

    private var lookID: Int

    private var lookData: LookData?

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

        var categoriesArray: [(String, [ItemData])] = categories.map {
            return ($0.key, $0.value)
        }

        categoriesArray.sort {
            $0.0 < $1.0
        }

        return LookData(lookName: model.lookName,
                        categories: categoriesArray.map {
                            return CategoryData(categoryName: $0.0,
                                                items: $0.1)
                        })
    }

    private func getItemIDs() -> [Int] {
        var ids: [Int] = []

        guard let lookData = lookData else {
            return ids
        }

        for i in .zero..<lookData.categories.count {
            for j in .zero..<lookData.categories[i].items.count {
                ids.append(lookData.categories[i].items[j].clothesID)
            }
        }

        return ids
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

            let model = self.convertToLookData(model: data)
            self.lookData = model
            self.output?.updateModel(model: model)
            self.output?.lookDidReceived()
        }
    }

    func getLookID() -> Int {
        return lookID
    }

    func deleteItems(categoryIndex: Int, itemIndex: Int) {
        guard let itemID = lookData?.categories[categoryIndex].items[itemIndex].clothesID else {
            return
        }

        lookData?.categories[categoryIndex].items.remove(at: itemIndex)

        if let category = lookData?.categories[categoryIndex],
           category.items.isEmpty {
            lookData?.categories.remove(at: categoryIndex)
        }

        guard let lookData = lookData else {
            return
        }

        output?.updateModel(model: lookData)

        DataService.shared.deleteItemFromLook(lookID: lookID,
                                              itemID: itemID) { [weak self] result in
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

            self.output?.lookDidReceived()
        }
    }

    func appendItemsToLook(items: [ItemData]) {
        guard var lookData = lookData else {
            return
        }

        for i in .zero..<items.count {

            var flag = false

            for j in .zero..<lookData.categories.count where lookData.categories[j].categoryName == items[i].category {
                    lookData.categories[j].items.append(items[i])
                    flag = true
                    break
            }

            if !flag {
                let newCategory = CategoryData(categoryName: items[i].category, items: [items[i]])
                lookData.categories.append(newCategory)
            }
        }

        self.lookData = lookData
        self.output?.updateModel(model: lookData)

        let itemIDs = getItemIDs()

        DataService.shared.updateLook(lookID: lookID,
                                      itemIDs: itemIDs) { [weak self] result in
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

            self.output?.lookDidReceived()
        }
    }
}
