import Foundation
import UIKit

protocol WardrobeUsersViewInput: class {
    func reloadDataWithAnimation()
    func reloadData()
    func changeEditButton(state: EditButtonState)
    func showAlert(alert: UIAlertController)
    func setWardrobeName(with name: String)
}

protocol WardrobeUsersViewOutput: class {
    func didLoadView()
    func didEditButtonTap()
    func isEditButtonTapped() -> Bool
    func didInivteUserButtonTapped()
    func getNumberOfUsers() -> Int
    func getWardrobeUser(at indexPath: IndexPath) -> WardrobeUserData
    func didDeleteUserTap(login: String)
    func refreshData()
}

protocol WardrobeUsersInteractorInput: class {
    func loadWardrobeUsers(with wardrobeId: Int)
    func deleteUser(login: String, wardrobeId: Int)
}

protocol WardrobeUsersInteractorOutput: class {
    func showAlert(title: String, message: String)
    func didReceive(with wardrobeUsers: [WardrobeUserData])
    func didDelete()
}

protocol WardrobeUsersRouterInput: class {
    func showInviteUser(with wardrobeId: Int)
}
