import Foundation
import Kingfisher

final class EditWardrobePresenter {
    weak var view: EditWardrobeViewInput?

    private let router: EditWardrobeRouterInput

    private let interactor: EditWardrobeInteractorInput

    private var model: EditWardrobePresenterData?

    private var imageChanged: Bool = false

    init(router: EditWardrobeRouterInput, interactor: EditWardrobeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EditWardrobePresenter: EditWardrobeViewOutput {
    func didTapGoBackButton() {
        router.goBack()
    }

    func didLoadView() {
        interactor.fetchWardrobeData()
    }

    func userDidSetImage(imageData: Data?) {
        guard let imageData = imageData else {
            return
        }

        imageChanged = true
        view?.setWardrobeImage(imageData: imageData)
    }

    func didTapEditImageView() {
        view?.showPickPhotoAlert()
    }

    func didTapEditWardrobeButton() {
        guard let itemName = view?.getWardrobeName(),
              !itemName.isEmpty else {
            view?.showAlert(title: "Ошибка", message: "Введите название предмета")
            return
        }

        interactor.saveWardrobeDataChanges(name: itemName, imageData: imageChanged ? view?.getWardrobeImageData() : nil)
    }

    func didTapView() {
        view?.disableKeyboard()
    }
}

extension EditWardrobePresenter: EditWardrobeInteractorOutput {
    func didSavedWardrobeData() {
        guard let model = model else {
            return
        }
        if let urlString = model.imageURL {
            let cacheKey = urlString + "&apikey=\(AuthService.shared.getApiKey())"
            KingfisherManager.shared.cache.removeImage(forKey: cacheKey)
        }

        router.goBack()
    }

    func didReceivedWardrobeData() {
        guard let model = model else {
            return
        }

        view?.setWardrobeName(name: model.name)

        guard let urlString = model.imageURL,
              let imageURL = URL(string: urlString + "&apikey=\(AuthService.shared.getApiKey())") else {
            view?.setWardrobeImage(url: nil)
            return
        }

        view?.setWardrobeImage(url: imageURL)
    }

    func showAlert(title: String, message: String) {
        view?.showAlert(title: title, message: message)
    }

    func updateModel(model: EditWardrobePresenterData) {
        self.model = model
    }
}
