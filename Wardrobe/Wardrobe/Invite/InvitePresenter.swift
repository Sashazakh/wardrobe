import Foundation
import UIKit

final class InvitePresenter {
	weak var view: InviteViewInput?

	private let router: InviteRouterInput
	private let interactor: InviteInteractorInput

    var wardrobeId: Int?

    init(router: InviteRouterInput, interactor: InviteInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension InvitePresenter: InviteViewOutput {
    func didUserTapInviteButton(with login: String) {
        guard let id = wardrobeId else { return }
        interactor.inviteUser(login: login, wardrobeId: id)
    }

}

extension InvitePresenter: InviteInteractorOutput {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)

        alert.addAction(okAction)
        view?.showAlert(alert: alert)
    }

}
