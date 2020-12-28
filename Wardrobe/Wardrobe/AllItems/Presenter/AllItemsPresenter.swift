import Foundation

final class AllItemsPresenter {
    weak var view: AllItemsViewInput?

    private let router: AllItemsRouterInput

    private let interactor: AllItemsInteractorInput

    private var model: AllItemsData?

    private var isSelected: [[Bool]]?

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
        router.showLookScreen()
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
                                                                  item: model.categories[index].items[i]))
        }

        return AllItemsTableViewCellViewModel(sectionName: model.categories[index].categoryName,
                                              itemModels: itemModels)
    }

    func setSelection(categoryIndex: Int, itemIndex: Int, isSelected: Bool) {
        self.isSelected?[categoryIndex][itemIndex] = isSelected
        view?.loadData()
    }
}

extension AllItemsPresenter: AllItemsInteractorOutput {
    func userItemsDidReceived() {
        view?.loadData()
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
