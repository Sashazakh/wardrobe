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

    init(router: MyInvitesRouterInput, interactor: MyInvitesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MyInvitesPresenter: MyInvitesViewOutput {
    func didInviteButtonTapped(at indexPath: IndexPath) {
        let alert = UIAlertController(title: Constants.inviteTitle,
                                      message: Constants.inviteMessage,
                                      preferredStyle: UIAlertController.Style.alert )
        let reset = UIAlertAction(title: "Принять", style: .default) { [self] (_) in
        }
        alert.addAction(reset)
        let splitOff = UIAlertAction(title: "Отклонить", style: .default) { [self] (_) in

        }
        alert.addAction(splitOff)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(cancel)
        view?.showAlert(alert: alert)
    }

}

extension MyInvitesPresenter: MyInvitesInteractorOutput {
}

extension MyInvitesPresenter {
    struct Constants {
        static let inviteTitle = "Приглашение в гардероб"
        static let inviteMessage = "Вы можете принять или отклонить приглашение"
    }
}
