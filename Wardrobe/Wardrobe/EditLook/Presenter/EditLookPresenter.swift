import Foundation

final class EditLookPresenter {
    weak var view: EditLookViewInput?

    private let router: EditLookRouterInput

    private let interactor: EditLookInteractorInput

    private var model: EditLookPresenterData?

    private var imageChanged: Bool = false

    init(router: EditLookRouterInput, interactor: EditLookInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EditLookPresenter: EditLookViewOutput {
    func didTapGoBackButton() {
        router.goBack()
    }

    func didLoadView() {
        interactor.fetchLookData()
    }

    func userDidSetImage(imageData: Data?) {
        guard let imageData = imageData else {
            return
        }

        imageChanged = true
        view?.setLookImage(imageData: imageData)
    }

    func didTapEditImageView() {
        view?.showPickPhotoAlert()
    }

    func didTapEditLookButton() {
        guard let itemName = view?.getLookName(),
              !itemName.isEmpty else {
            view?.showAlert(title: "Ошибка", message: "Введите название предмета")
            return
        }

        interactor.saveLookDataChanges(name: itemName, imageData: imageChanged ? view?.getLookImageData() : nil)
    }

    func didTapView() {
        view?.disableKeyboard()
    }
}

extension EditLookPresenter: EditLookInteractorOutput {
    func didSavedLookData() {
        router.goBack()
    }

    func didReceivedLookData() {
        guard let model = model else {
            return
        }

        view?.setLookName(name: model.name)

        guard let urlString = model.imageURL,
              let imageURL = URL(string: urlString + "&apikey=\(AuthService.shared.getApiKey())") else {
            view?.setLookImage(url: nil)
            return
        }

        view?.setLookImage(url: imageURL)
    }

    func showAlert(title: String, message: String) {
        view?.showAlert(title: title, message: message)
    }

    func updateModel(model: EditLookPresenterData) {
        self.model = model
    }
}
