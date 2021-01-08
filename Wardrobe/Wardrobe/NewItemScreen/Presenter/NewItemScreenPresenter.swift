import Foundation
import UIKit

final class NewItemScreenPresenter {
	weak var view: NewItemScreenViewInput?

	private let router: NewItemScreenRouterInput
	private let interactor: NewItemScreenInteractorInput

    init(router: NewItemScreenRouterInput, interactor: NewItemScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension NewItemScreenPresenter: NewItemScreenViewOutput {
    func didTapBackButton() {
        router.goBack()
    }

    func didTapAddButton() {
        guard let itemName = view?.getItemName(),
              !itemName.isEmpty else {
            view?.turnOnButtonInteraction()
            view?.showAlert(title: "Ошибка", message: "Введите название предмета")
            return
        }

        interactor.addItem(name: itemName, imageData: view?.getItemImage())
    }

    func didTapView() {
        view?.disableKeyboard()
    }
}

extension NewItemScreenPresenter: NewItemScreenInteractorOutput {
    func showAlert(title: String, message: String) {
        view?.turnOnButtonInteraction()
        view?.showAlert(title: title, message: message)
    }

    func didItemAdded() {
        router.goBack()
    }
}
