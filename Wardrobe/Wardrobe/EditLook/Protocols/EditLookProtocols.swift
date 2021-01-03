import Foundation

protocol EditLookViewInput: AnyObject {
    func showPickPhotoAlert()

    func setLookName(name: String)

    func setLookImage(imageData: Data?)

    func setLookImage(url: URL?)

    func getLookImageData() -> Data?

    func getLookName() -> String?

    func showAlert(title: String, message: String)

    func disableKeyboard()
}

protocol EditLookViewOutput: AnyObject {
    func didTapGoBackButton()

    func didLoadView()

    func didTapEditImageView()

    func didTapEditLookButton()

    func userDidSetImage(imageData: Data?)

    func didTapView()
}

protocol EditLookInteractorInput: AnyObject {
    func fetchLookData()

    func saveLookDataChanges(name: String, imageData: Data?)
}

protocol EditLookInteractorOutput: AnyObject {
    func showAlert(title: String, message: String)

    func didReceivedLookData()

    func didSavedLookData()

    func updateModel(model: EditLookPresenterData)
}

protocol EditLookRouterInput: AnyObject {
    func goBack()
}
