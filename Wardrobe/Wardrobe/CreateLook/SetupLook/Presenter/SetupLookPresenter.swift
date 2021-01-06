import Foundation

final class SetupLookPresenter {
	weak var view: SetupLookViewInput?

	private let router: SetupLookRouterInput
	private let interactor: SetupLookInteractorInput

    init(router: SetupLookRouterInput, interactor: SetupLookInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SetupLookPresenter: SetupLookViewOutput {
    func didTapBackToCreateWardrobeButton() {
        router.backToCreateLookScreen()
    }

    func didTapAddLookPhotoButton() {
        view?.showPickPhotoAlert()
    }

    func didTapSetupLookButton() {
        view?.disableSetupButtonInteraction()

        guard let lookName = view?.getLookName(),
              !lookName.isEmpty else {
            view?.showAlert(title: "Ошибка", message: "Введите имя набора")
            view?.enableSetupButtonInteraction()
            return
        }

        let imageData = view?.getLookImage()

        interactor.createLook(name: lookName, imageData: imageData)
    }

    func userDidSetImage(imageData: Data?) {
        guard let data = imageData else {
            return
        }

        view?.setLookImage(imageData: data)
    }

    func didTapView() {
        view?.disableKeyboard()
    }
}

extension SetupLookPresenter: SetupLookInteractorOutput {
    func lookDidSaved() {
        router.backToWardrobeScreen()
    }

    func showAlert(title: String, message: String) {
        view?.showAlert(title: title, message: message)
        view?.enableSetupButtonInteraction()
    }
}
