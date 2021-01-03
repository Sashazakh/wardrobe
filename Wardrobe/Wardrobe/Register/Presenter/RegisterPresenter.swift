import Foundation

final class RegisterPresenter {
	weak var view: RegisterViewInput?

	private let router: RegisterRouterInput

	private let interactor: RegisterInteractorInput

    private var model: RegisterData?

    private var userImageIsSet = false

    init(router: RegisterRouterInput, interactor: RegisterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension RegisterPresenter: RegisterViewOutput {
    func didTapCheckBox() {
        interactor.toggleTermsState()
        interactor.termsAreAccepted() ? view?.setCheckBoxChecked() : view?.setCheckBoxUnchecked()
    }

    func didTapLoginLabel() {
        router.showLoginScreen()
    }

    func didTapAddPhotoButton() {
        view?.showPickPhotoAlert()
    }

    func didTapRegisterButton() {
        guard let userCredentials = view?.getNewUserCredentials() else {
            return
        }

        guard let login = (userCredentials["login"] ?? ""),
              !login.isEmpty else {
            view?.showAlert(title: "Ошибка", message: "Введите логин")
            return
        }

        guard let fio = (userCredentials["fio"] ?? ""),
              !fio.isEmpty else {
            view?.showAlert(title: "Ошибка", message: "Введите ФИО")
            return
        }

        guard let password = (userCredentials["password"] ?? ""),
              !password.isEmpty else {
            view?.showAlert(title: "Ошибка", message: "Введите пароль")
            return
        }

        guard let repeatPassword = (userCredentials["repeatPassword"] ?? ""),
              !repeatPassword.isEmpty else {
            view?.showAlert(title: "Ошибка", message: "Повторите пароль")
            return
        }

        guard password == repeatPassword else {
            view?.showAlert(title: "Ошибка", message: "Пароли не совпадают")
            return
        }

        let imageData = userImageIsSet ? view?.getUserImage() : nil

        interactor.register(login: login,
                            fio: fio,
                            password: password,
                            imageData: imageData)
    }

    func userDidSetImage(imageData: Data?) {
        guard let data = imageData else {
            return
        }

        userImageIsSet = true
        view?.setUserImage(imageData: data)
    }

    func didTapView() {
        view?.disableKeyboard()
    }
}

extension RegisterPresenter: RegisterInteractorOutput {
    func showAlert(title: String, message: String) {
        view?.showAlert(title: title, message: message)
    }

    func userSuccesfullyRegistered() {
        guard let model = model else {
            return
        }

        router.showWardrobeScreen(model: model)
    }

    func updateModel(model: RegisterData) {
        self.model = model
    }
}
