import Foundation

final class LookPresenter {
	weak var view: LookViewInput?

	private let router: LookRouterInput

	private let interactor: LookInteractorInput

    private var isEditing: Bool = false

    private var menuIsDropped: Bool = false

    private var refreshNeeded: Bool = false

    private var model: LookData?

    init(router: LookRouterInput, interactor: LookInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LookPresenter: LookViewOutput {
    func didTapLookParamsButton() {
        if self.isEditing {
            self.isEditing = false
            view?.hideEditLayout()
            view?.setLookIsEditing(isEditing: self.isEditing)
        } else {
            menuIsDropped = !menuIsDropped
            menuIsDropped ? view?.showDropMenu() : view?.hideDropMenu()
        }
    }

    func didTapBackToWardrobeButton() {
        router.showWardrobeScreen()
    }

    func didLoadView() {
        interactor.fetchLook()
    }

    func didRequestRefresh() {
        refreshNeeded = true
        interactor.fetchLook()
    }

    func getRowsCount() -> Int {
        return model?.categories.count ?? .zero
    }

    func viewModel(index: Int) -> LookTableViewCellViewModel {
        guard let model = model else {
            return LookTableViewCellViewModel(sectionName: "Default", itemModels: [])
        }

        let itemModels = model.categories[index].items.map { item in
            return ItemCollectionViewCellViewModel(item: item)
        }

        return LookTableViewCellViewModel(sectionName: model.categories[index].categoryName,
                                          itemModels: itemModels)
    }

    func deleteViewModel(tableCellIndex: Int, collectionCellIndex: Int) {
        interactor.deleteItems(categoryIndex: tableCellIndex, itemIndex: collectionCellIndex)
    }

    func didUserAddItems(items: [ItemData]) {
        interactor.appendItemsToLook(items: items)
    }

    func didTapDeleteItems() {
        menuIsDropped = false
        view?.hideDropMenu()
        self.isEditing = true

        view?.showEditLayout()
        view?.setLookIsEditing(isEditing: self.isEditing)
    }

    func didTapAddItems() {
        menuIsDropped = false
        view?.hideDropMenu()

        router.showAllItemsScreen(lookID: interactor.getLookID(), ownerLogin: interactor.getOwnerLogin())
    }
}

extension LookPresenter: LookInteractorOutput {
    func updateModel(model: LookData) {
        self.model = model
    }

    func lookDidReceived() {
        if refreshNeeded {
            interactor.refreshImageCache()
            refreshNeeded = false
        }

        view?.setLookTitle(with: model?.lookName ?? String())
        view?.loadData()
    }

    func showAlert(title: String, message: String) {
        view?.showAlert(title: title, message: message)
    }
}
