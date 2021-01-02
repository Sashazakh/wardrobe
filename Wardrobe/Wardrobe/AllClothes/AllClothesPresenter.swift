import Foundation

final class AllClothesPresenter {
	weak var view: AllClothesViewInput?
    var model: AllClothesModel? {
        didSet {
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

    func didTapItem() {
        router.showEditItemScreen()
    }
}

extension AllClothesPresenter: AllClothesInteractorOutput {
    func handleModel(model: AllClothesModel) {
        self.model = model
    }

    func showAlert(title: String, message: String) {
        self.router.showAlert(title: title, message: message)
    }

}
