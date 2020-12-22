import Foundation

final class AllItemsPresenter {
    weak var view: AllItemsViewInput?

    private let router: AllItemsRouterInput

    private let interactor: AllItemsInteractorInput

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
}

extension AllItemsPresenter: AllItemsInteractorOutput {
}
