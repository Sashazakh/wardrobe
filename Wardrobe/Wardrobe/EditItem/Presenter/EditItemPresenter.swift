import Foundation

final class EditItemPresenter {
	weak var view: EditItemViewInput?

	private let router: EditItemRouterInput

	private let interactor: EditItemInteractorInput

    private var model: EditItemPresenterData?

    private var imageChanged: Bool = false

    init(router: EditItemRouterInput, interactor: EditItemInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EditItemPresenter: EditItemViewOutput {
    func didTapGoBackButton() {
        router.goBack()
    }

    func didLoadView() {
        interactor.fetchItem()
    }

    func userDidSetImage(imageData: Data?) {
        guard let imageData = imageData else {
            return
        }

        imageChanged = true
        view?.setItemImage(imageData: imageData)
    }

    func didTapEditImageView() {
        view?.showPickPhotoAlert()
    }

    func didTapEditItemButton() {
        guard let itemName = view?.getItemName(),
              !itemName.isEmpty else {
            view?.showAlert(title: "Ошибка", message: "Введите название предмета")
            return
        }

        interactor.saveItemChanges(name: itemName, imageData: imageChanged ? view?.getItemImageData() : nil)
    }

    func didSavedItemData() {
        router.goBack()
    }
}

extension EditItemPresenter: EditItemInteractorOutput {
    func didReceivedItemData() {
        guard let model = model else {
            return
        }

        view?.setItemName(name: model.name)

        guard let urlString = model.imageURL,
              let imageURL = URL(string: urlString + "&apikey=\(AuthService.shared.getApiKey())") else {
            view?.setItemImage(url: nil)
            return
        }

        view?.setItemImage(url: imageURL)
    }

    func showAlert(title: String, message: String) {
        view?.showAlert(title: title, message: message)
    }

    func updateModel(model: EditItemPresenterData) {
        self.model = model
    }
}
