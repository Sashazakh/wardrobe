//
//  MyInvitesPresenter.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 28.12.2020.
//  
//

import Foundation
import UIKit

final class MyInvitesPresenter {
	weak var view: MyInvitesViewInput?

	private let router: MyInvitesRouterInput
	private let interactor: MyInvitesInteractorInput

    private var invites: [MyInvitesData] = [] {
        didSet {
            DispatchQueue.main.async {
                if self.invites.isEmpty {
                    self.view?.showNoDataLabel()
                }
                self.view?.reloadData()
            }
        }
    }

    private var tappedWardobe: IndexPath?

    init(router: MyInvitesRouterInput, interactor: MyInvitesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MyInvitesPresenter: MyInvitesViewOutput {
    func didLoadView() {
        interactor.loadInvites()
    }

    func didInviteButtonTapped(at indexPath: IndexPath) {
        let alert = UIAlertController(title: Constants.inviteTitle,
                                      message: Constants.inviteMessage,
                                      preferredStyle: UIAlertController.Style.alert )
        let reset = UIAlertAction(title: "Принять", style: .default) { [self] (_) in
            tappedWardobe = indexPath
            guard let invite = getInvite(at: indexPath) else { return }
            interactor.didUserAcceptWardrobe(with: invite.id)
        }
        alert.addAction(reset)
        let splitOff = UIAlertAction(title: "Отклонить", style: .default) { [self] (_) in
            tappedWardobe = indexPath
            guard let invite = getInvite(at: indexPath) else { return }
            interactor.didUserDenyWardrobe(with: invite.id)
        }
        alert.addAction(splitOff)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(cancel)
        view?.showAlert(alert: alert)
    }

    func getInvite(at indexPath: IndexPath) -> MyInvitesData? {
        return invites[indexPath.row]
    }

    func getNumberOfInvites() -> Int {
        return invites.count
    }
}

extension MyInvitesPresenter: MyInvitesInteractorOutput {
    func removeWardrobe() {
        guard let tappedWardrobe = tappedWardobe else { return }
        invites.remove(at: tappedWardrobe.row)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)

        alert.addAction(okAction)
        view?.showAlert(alert: alert)
    }

    func didReceive(with invites: [MyInvitesData]) {
        self.invites = invites
    }
}

extension MyInvitesPresenter {
    struct Constants {
        static let inviteTitle = "Приглашение в гардероб"
        static let inviteMessage = "Вы можете принять или отклонить приглашение"
    }
}
