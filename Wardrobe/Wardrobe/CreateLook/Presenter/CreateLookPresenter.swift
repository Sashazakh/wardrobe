import Foundation

final class CreateLookPresenter {
    weak var view: CreateLookViewInput?

    private let router: CreateLookRouterInput

    private let interactor: CreateLookInteractorInput

    private var model: AllItemsData?

    private var isSelected: [[Bool]]?

    private var needsToRefresh: [[Bool]]?

    private var resfreshRequested: Bool = false

    init(router: CreateLookRouterInput, interactor: CreateLookInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CreateLookPresenter: CreateLookViewOutput {
    func didTapBackToWardrobeDetailButton() {
        router.showWardrobeDetailScreen()
    }

    func didTapConfirmButton() {
        guard let status = isSelected,
              let model = model else {
            return
        }

        var ids: [Int] = []

        for i in .zero..<status.count {
            for j in .zero..<status[i].count where status[i][j] {
                ids.append(model.categories[i].items[j].clothesID)
            }
        }

        if model.categories.isEmpty {
            router.showWardrobeDetailScreen()
            return
        }

        if ids.isEmpty {
            view?.showAlert(title: "Ошибка", message: "Не выбрано ни одного предмета")
            return
        }

        router.showSetupLookScreen(wardrobeID: interactor.getWardrobeID(), itemsID: ids)
    }

    func didLoadView() {
        interactor.fetchAllItems()
    }

    func getRowsCount() -> Int {
        return model?.categories.count ?? .zero
    }

    func viewModel(index: Int) -> AllItemsTableViewCellViewModel {
        guard let model = model else {
            return AllItemsTableViewCellViewModel(sectionName: "Default", itemModels: [])
        }

        var itemModels: [AllItemsCollectionViewCellViewModel] = []

        for i in .zero..<model.categories[index].items.count {
            itemModels.append(AllItemsCollectionViewCellViewModel(isSelected: isSelected?[index][i] ?? false,
                                                                  needsToRefresh: needsToRefresh?[index][i] ?? false,
                                                                  item: model.categories[index].items[i]))
        }

        return AllItemsTableViewCellViewModel(sectionName: model.categories[index].categoryName,
                                              itemModels: itemModels)
    }

    func setSelection(categoryIndex: Int, itemIndex: Int, isSelected: Bool) {
        self.isSelected?[categoryIndex][itemIndex] = isSelected
        view?.loadData()
    }

    func didRefreshCache(categoryIndex: Int, itemIndex: Int) {
        self.needsToRefresh?[categoryIndex][itemIndex] = false
    }

    func didRequestRefresh() {
        resfreshRequested = true
        interactor.fetchAllItems()
    }
}

extension CreateLookPresenter: CreateLookInteractorOutput {
    func updateModel(model: AllItemsData) {
        self.model = model

        self.isSelected = [[Bool]](repeating: [], count: model.categories.count)

        for i in .zero..<model.categories.count {
            self.isSelected?[i] = [Bool](repeating: false, count: model.categories[i].items.count)
        }

        if resfreshRequested {
            self.needsToRefresh = [[Bool]](repeating: [], count: model.categories.count)

            for i in .zero..<model.categories.count {
                self.needsToRefresh?[i] = [Bool](repeating: true, count: model.categories[i].items.count)
            }

            resfreshRequested = false
        }
    }

    func allItemsSuccesfullyReceived() {
        guard let model = model else {
            return
        }

        if model.categories.isEmpty {
            view?.showNoItemsLabel()
        } else {
            view?.loadData()
        }
    }

    func showAlert(title: String, message: String) {
        view?.showAlert(title: title, message: message)
    }
}
