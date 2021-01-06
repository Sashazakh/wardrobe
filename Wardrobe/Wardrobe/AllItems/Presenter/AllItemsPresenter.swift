import Foundation

final class AllItemsPresenter {
    weak var view: AllItemsViewInput?

    private let router: AllItemsRouterInput

    private let interactor: AllItemsInteractorInput

    private var model: AllItemsData?

    private var isSelected: [[Bool]]?

    private var needsToRefresh: [[Bool]]?

    private var refreshRequested: Bool = false

    init(router: AllItemsRouterInput, interactor: AllItemsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AllItemsPresenter: AllItemsViewOutput {
    func didTapBackToLookButton() {
        router.showLookScreen()
    }

    func didTapConfirmButton() {
        var items: [ItemData] = []

        guard let status = isSelected,
              let model = model else {
            return
        }

        for i in .zero..<status.count {
            for j in .zero..<status[i].count where status[i][j] {
                items.append(model.categories[i].items[j])
            }
        }

        guard !items.isEmpty else {
            router.showLookScreen()
            return
        }

        router.showLookScreen(items: items)
    }

    func didLoadView() {
        interactor.fetchUserItems()
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

        if refreshRequested {
            self.needsToRefresh = [[Bool]](repeating: [], count: model.categories.count)

            for i in .zero..<model.categories.count {
                self.needsToRefresh?[i] = [Bool](repeating: true, count: model.categories[i].items.count)
            }

            refreshRequested = false
        }

        return AllItemsTableViewCellViewModel(sectionName: model.categories[index].categoryName,
                                              itemModels: itemModels)
    }

    func setSelection(categoryIndex: Int, itemIndex: Int) {
        guard let state = isSelected?[categoryIndex][itemIndex] else {
            return
        }

        self.isSelected?[categoryIndex][itemIndex] = !state
        view?.loadData()
    }

    func didRefreshed(categoryIndex: Int, itemIndex: Int) {
        self.needsToRefresh?[categoryIndex][itemIndex] = false
    }

    func didRefreshRequested() {
        refreshRequested = true
        interactor.fetchUserItems()
    }
}

extension AllItemsPresenter: AllItemsInteractorOutput {
    func userItemsDidReceived() {
        guard let model = model else {
            return
        }

        if model.categories.count == .zero {
            view?.showNoItemsLabel()
        } else {
            view?.loadData()
        }
    }

    func showAlert(title: String, message: String) {
        view?.showAlert(title: title, message: message)
    }

    func updateModel(model: AllItemsData) {
        self.model = model
        self.isSelected = [[Bool]](repeating: [], count: model.categories.count)

        for i in .zero..<model.categories.count {
            self.isSelected?[i] = [Bool](repeating: false, count: model.categories[i].items.count)
        }
    }
}
