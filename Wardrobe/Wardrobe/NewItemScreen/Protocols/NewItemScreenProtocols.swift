import Foundation
import UIKit

protocol NewItemScreenViewInput: AnyObject {
    func getItemName() -> String?

    func getItemImage() -> Data?

    func showAlert(title: String, message: String)
}

protocol NewItemScreenViewOutput: AnyObject {
    func didImageLoaded(image: UIImage)

    func didTapBackButton()

    func didTapAddButton()
}

protocol NewItemScreenInteractorInput: AnyObject {
    func addItem(name: String, imageData: Data?)
}

protocol NewItemScreenInteractorOutput: AnyObject {
    func showAlert(title: String, message: String)
}

protocol NewItemScreenRouterInput: AnyObject {
    func goBack()
}
