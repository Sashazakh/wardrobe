import Foundation
import UIKit

protocol WardrobeDetailViewInput: class {
    func reloadDataWithAnimation()
    func showAlert(alert: UIAlertController)
    func reloadData()
    func setWardrobeName(with name: String)
    func changeEditButton(state: EditButtonState)
    func hideDropMenu()
}

protocol WardrobeDetailViewOutput: class {
    func didPersonTap()
    func didTapLook(at indexPath: IndexPath)
    func didTapCreateLookCell()
    func didLoadView()
    func getNumberOfLooks() -> Int
    func look(at indexPath: IndexPath) -> WardrobeDetailData
    func didEditButtonTap()
    func isEditButtonTapped() -> Bool
}

protocol WardrobeDetailInteractorInput: class {
    func loadLooks(with wardrobeId: Int)
}

protocol WardrobeDetailInteractorOutput: class {
    func didReceive(with: [WardrobeDetailData])
    func showAlert(title: String, message: String)

}

protocol WardrobeDetailRouterInput: class {
    func showPersons(wardrobeId: Int, wardrobeName: String)
    func showLookScreen(with lookId: Int)
    func showCreateLookScreen()
}
