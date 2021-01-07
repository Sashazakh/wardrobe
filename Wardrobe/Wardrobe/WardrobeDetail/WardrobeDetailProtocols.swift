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
    func refreshData()
    func didDeleteLookTap(with lookData: WardrobeDetailData)
    func didEditLookTap(at indexPath: IndexPath)
}

protocol WardrobeDetailInteractorInput: class {
    func loadLooks(with wardrobeId: Int)
    func deleteLook(lookId: Int)
    func cleanImageCache(for models: [WardrobeDetailData])
}

protocol WardrobeDetailInteractorOutput: class {
    func didReceive(with: [WardrobeDetailData])
    func showAlert(title: String, message: String)
    func didDelete()
}

protocol WardrobeDetailRouterInput: class {
    func showPersons(wardrobeId: Int, wardrobeName: String)
    func showLookScreen(with lookId: Int)
    func showCreateLookScreen(wardrobeId: Int, creatorLogin: String)
    func showEditLook(with lookId: Int)
}
