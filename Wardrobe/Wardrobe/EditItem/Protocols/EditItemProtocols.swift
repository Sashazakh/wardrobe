import Foundation

protocol EditItemViewInput: AnyObject {
    func showPickPhotoAlert()

    func setItemName(name: String)

    func setItemImage(imageData: Data?)

    func setItemImage(url: URL?)

    func getItemImageData() -> Data?

    func getItemName() -> String?

    func showAlert(title: String, message: String)

    func disableKeyboard()
}

protocol EditItemViewOutput: AnyObject {
    func didTapGoBackButton()

    func didLoadView()

    func didTapEditImageView()

    func didTapEditItemButton()

    func userDidSetImage(imageData: Data?)

    func didTapView()
}

protocol EditItemInteractorInput: AnyObject {
    func fetchItem()

    func saveItemChanges(name: String, imageData: Data?)
}

protocol EditItemInteractorOutput: AnyObject {
    func showAlert(title: String, message: String)

    func didReceivedItemData()

    func didSavedItemData()

    func updateModel(model: EditItemPresenterData)
}

protocol EditItemRouterInput: AnyObject {
    func goBack()
}
