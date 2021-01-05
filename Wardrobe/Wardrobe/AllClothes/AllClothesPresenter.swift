import Foundation

final class AllClothesPresenter {
	weak var view: AllClothesViewInput?
    private var menuIsDropped: Bool = false
    var model: AllClothesModel? {
        didSet {
            model?.categories.sort {
                $0.categoryName < $1.categoryName
            }
            view?.reloadData()
        }
    }

	private let router: AllClothesRouterInput
	private let interactor: AllClothesInteractorInput

    init(router: AllClothesRouterInput, interactor: AllClothesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AllClothesPresenter: AllClothesViewOutput {
    func deleteItem(id: Int) {
        interactor.deleteItem(id: id)
    }

    func didTapMoreMenuButton() {
        guard let view = self.view else { return }
        menuIsDropped.toggle()
        menuIsDropped ? view.showDropMenu() : view.hideDropMenu()
    }
    func didTapNewCategoryButton() {
        guard var model = self.model else { return }
        router.showNewCategoryAlert { [weak self] category in
            guard let self = self else {
                return
            }
            model.categories.append(CategoryData(categoryName: category, items: []))
            self.model = model
        }
    }

    func didTapEditButton() {
        guard let view = self.view else { return }
        view.toggleEditMode()
        if view.getEditMode() {
            didTapMoreMenuButton()
            view.changeEditButton(state: .accept)
        } else {
            view.changeEditButton(state: .edit)
        }
        view.reloadData()
    }

    func didTapAddItem(category: String) {
        router.showAddItemScreen(category: category)
    }

    func getCategory(for index: Int) -> CategoryData? {
        guard let data = self.model else { return nil }
        if index < data.categories.count {
            return data.categories[index]
        } else {
            return nil
        }
    }

    func getTitle(for index: Int) -> String {
        guard let data = self.model else { return "" }
        if index < data.categories.count {
            return data.categories[index].categoryName
        } else {
            return ""
        }

    }

    func getCategoriesCount() -> Int {
        return model?.categories.count ?? 0
    }

    func didLoadView() {
        interactor.getAllClothes()
    }

    func didRefreshRequested() {
        interactor.getAllClothes()
    }

    func didTapItem(itemId: Int) {
        router.showEditItemScreen(itemId: itemId)
    }
}

extension AllClothesPresenter: AllClothesInteractorOutput {
    func didDeletedItem() {
        interactor.getAllClothes()
        // guard var newmodel = self.model else { return }
        // newmodel.categories[collectionIndex].items.remove(at: cellIndex)
        // model = newmodel
        // view?.reloadData()
    }

    func handleModel(model: AllClothesModel) {
        self.model = model
    }

    func showAlert(title: String, message: String) {
        self.router.showAlert(title: title, message: message)
    }

}
