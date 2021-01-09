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
    func didTapConditionsLabel() {
        router.showTermsAndConditions()
    }

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
            view?.showAlert(title: "Ошибка", message: "Введите имя пользователя")
            return
        }

        guard login.isValidString() else {
            let msg = "Возможны только строчные и заглавные буквы латинского алфавита (a-z, A-Z) и цифры от 0 до 9"
            self.showAlert(title: "Недопустимые символы в поле ввода пароля!", message: msg)
            return
        }

        guard let password = (userCredentials["password"] ?? ""),
              !password.isEmpty else {
            view?.showAlert(title: "Ошибка", message: "Введите пароль")
            return
        }

        guard password.isValidString() else {
            let msg = "Возможны только строчные и заглавные буквы латинского алфавита (a-z, A-Z) и цифры от 0 до 9"
            self.showAlert(title: "Недопустимые символы в поле ввода пароля!", message: msg)
            return
        }

        guard let repeatPassword = (userCredentials["repeatPassword"] ?? ""),
              !repeatPassword.isEmpty else {
            view?.showAlert(title: "Ошибка", message: "Повторите пароль")
            return
        }

        guard repeatPassword.isValidString() else {
            let msg = "Возможны только строчные и заглавные буквы латинского алфавита (a-z, A-Z) и цифры от 0 до 9"
            self.showAlert(title: "Недопустимые символы в поле ввода пароля!", message: msg)
            return
        }

        guard password == repeatPassword else {
            view?.showAlert(title: "Ошибка", message: "Пароли не совпадают")
            return
        }

        let imageData = userImageIsSet ? view?.getUserImage() : nil

        interactor.register(login: login,
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
