import Foundation
import UIKit

final class WardrobeUsersPresenter {
	weak var view: WardrobeUsersViewInput?

	private let router: WardrobeUsersRouterInput
	private let interactor: WardrobeUsersInteractorInput

    private var isUserEditButtonTapped: Bool = false

    var wardrobeId: Int?
    var wardrobeName: String?

    private var wardrobeUsers: [WardrobeUserData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }

    private var isLoadView: Bool = false

    init(router: WardrobeUsersRouterInput, interactor: WardrobeUsersInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension WardrobeUsersPresenter: WardrobeUsersViewOutput {
    func refreshData() {
        guard let wardrobeId = wardrobeId else { return }
        interactor.loadWardrobeUsers(with: wardrobeId)
    }

    func didDeleteUserTap(login: String) {
        guard let wardrobeId = wardrobeId else { return }
        interactor.deleteUser(login: login, wardrobeId: wardrobeId)
    }

    func getWardrobeUser(at indexPath: IndexPath) -> WardrobeUserData {
        return wardrobeUsers[indexPath.row]
    }

    func didLoadView() {
        if let name = wardrobeName, !isLoadView {
            view?.setWardrobeName(with: name)
        }
        guard let wardrobeId = wardrobeId else { return }
        interactor.loadWardrobeUsers(with: wardrobeId)
        isLoadView = true
    }

    func didEditButtonTap() {
        isUserEditButtonTapped = !isUserEditButtonTapped
        view?.reloadDataWithAnimation()
        if isEditButtonTapped() {
            view?.changeEditButton(state: .accept)
        } else {
            view?.changeEditButton(state: .edit)
        }
    }

    func isEditButtonTapped() -> Bool {
        return isUserEditButtonTapped
    }

    func didInivteUserButtonTapped() {
        guard let id = wardrobeId else { return }
        router.showInviteUser(with: id)
    }

    func getNumberOfUsers() -> Int {
        return wardrobeUsers.count
    }
}

extension WardrobeUsersPresenter: WardrobeUsersInteractorOutput {
    func didDelete() {
        guard let id = wardrobeId else { return }
        interactor.loadWardrobeUsers(with: id)
    }

    func didReceive(with wardrobeUsers: [WardrobeUserData]) {
        self.wardrobeUsers = wardrobeUsers
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)

        alert.addAction(okAction)
        view?.showAlert(alert: alert)
    }

}
