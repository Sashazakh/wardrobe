import Foundation

final class LookPresenter {
	weak var view: LookViewInput?

	private let router: LookRouterInput

	private let interactor: LookInteractorInput

    private var isEditing: Bool = false

    private var model: LookData?

    init(router: LookRouterInput, interactor: LookInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LookPresenter: LookViewOutput {
    func didTapEditLookButton() {
        isEditing ? view?.hideEditLayout() : view?.showEditLayout()
        isEditing = !isEditing
        view?.setLookIsEditing(isEditing: isEditing)
    }

    func didTapBackToWardrobeButton() {
        router.showWardrobeScreen()
    }

    func didTapAddItemsButton() {
        router.showAllItemsScreen()
    }

    func didLoadView() {
        interactor.fetchLook()
    }

    func getRowsCount() -> Int {
        return model?.categories.count ?? .zero
    }

    func viewModel(index: Int) -> LookTableViewCellViewModel {
        guard let model = model else {
            return LookTableViewCellViewModel(sectionName: "Default", itemModels: [])
        }

        let itemModels = model.categories.map {
            return ItemCollectionViewCellViewModel(items: $0.items)
        }

        return LookTableViewCellViewModel(sectionName: model.lookName,
                                          itemModels: itemModels)
    }
}

extension LookPresenter: LookInteractorOutput {
    func updateModel(model: LookData) {
        self.model = model
    }

    func lookDidReceived() {
        view?.loadData()
    }

    func showAlert(title: String, message: String) {
        view?.showAlert(title: title, message: message)
    }
}
