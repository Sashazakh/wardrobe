import Foundation

final class AllItemsPresenter {
    weak var view: AllItemsViewInput?

    private let router: AllItemsRouterInput

    private let interactor: AllItemsInteractorInput

    private var model: AllItemsData?

    private var isEditing: Bool = false

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
        interactor.fetchAllItems()
    }

    func getRowsCount() -> Int {
        return model?.categories.count ?? .zero
    }

    func viewModel(index: Int) -> AllItemsTableViewCellViewModel {
        guard let model = model else {
            return AllItemsTableViewCellViewModel(sectionName: "Default", itemModels: [])
        }

        let itemModels = model.categories[index].items.map { item in
            return AllItemsCollectionViewCellViewModel(item: item)
        }

        return AllItemsTableViewCellViewModel(sectionName: model.categories[index].categoryName,
                                          itemModels: itemModels)
    }
}

extension AllItemsPresenter: AllItemsInteractorOutput {
    func showAlert(title: String, message: String) {
        view?.showAlert(title: title, message: message)
    }

    func updateModel(model: AllItemsData) {
        self.model = model
    }

    func allItemsDidReceived() {
        view?.loadData()
    }
}
