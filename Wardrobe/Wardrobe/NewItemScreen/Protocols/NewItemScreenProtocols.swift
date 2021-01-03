import Foundation
import UIKit

protocol NewItemScreenViewInput: AnyObject {
    func getItemName() -> String?

    func getItemImage() -> Data?

    func showAlert(title: String, message: String)

    func disableKeyboard()
}

protocol NewItemScreenViewOutput: AnyObject {
    func didTapBackButton()

    func didTapAddButton()

    func didTapView()
}

protocol NewItemScreenInteractorInput: AnyObject {
    func addItem(name: String, imageData: Data?)
}

protocol NewItemScreenInteractorOutput: AnyObject {
    func showAlert(title: String, message: String)

    func didItemAdded()
}

protocol NewItemScreenRouterInput: AnyObject {
    func goBack()
}
