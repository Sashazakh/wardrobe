import Foundation

protocol EditWardrobeViewInput: AnyObject {
    func showPickPhotoAlert()

    func setWardrobeName(name: String)

    func setWardrobeImage(imageData: Data?)

    func setWardrobeImage(url: URL?)

    func getWardrobeImageData() -> Data?

    func getWardrobeName() -> String?

    func showAlert(title: String, message: String)

    func disableKeyboard()
}

protocol EditWardrobeViewOutput: AnyObject {
    func didTapGoBackButton()

    func didLoadView()

    func didTapEditImageView()

    func didTapEditWardrobeButton()

    func userDidSetImage(imageData: Data?)

    func didTapView()
}

protocol EditWardrobeInteractorInput: AnyObject {
    func fetchWardrobeData()

    func saveWardrobeDataChanges(name: String, imageData: Data?)
}

protocol EditWardrobeInteractorOutput: AnyObject {
    func showAlert(title: String, message: String)

    func didReceivedWardrobeData()

    func didSavedWardrobeData()

    func updateModel(model: EditWardrobePresenterData)
}

protocol EditWardrobeRouterInput: AnyObject {
    func goBack()
}
