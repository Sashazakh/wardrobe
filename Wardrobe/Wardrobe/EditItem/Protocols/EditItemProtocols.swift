import Foundation

protocol EditItemViewInput: AnyObject {
    func showPickPhotoAlert()

    func setItemName(name: String)

    func setItemImage(imageData: Data?)

    func setItemImage(url: URL?)

    func showAlert(title: String, message: String)
}

protocol EditItemViewOutput: AnyObject {
    func didTapGoBackButton()

    func didLoadView()

    func didTapEditImageView()

    func userDidSetImage(imageData: Data?)
}

protocol EditItemInteractorInput: AnyObject {
    func fetchItem()
}

protocol EditItemInteractorOutput: AnyObject {
    func showAlert(title: String, message: String)

    func didReceivedItemData()

    func updateModel(model: EditItemPresenterData)
}

protocol EditItemRouterInput: AnyObject {
    func goBack()
}
