//
//  MyInvitesInteractor.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 28.12.2020.
//  
//

import Foundation

enum InviteWardrobeResponse: Int {
    case deny = 0, accept = 1
}

final class MyInvitesInteractor {
	weak var output: MyInvitesInteractorOutput?
}

extension MyInvitesInteractor: MyInvitesInteractorInput {
    func didUserAcceptWardrobe(with id: Int) {
        DataService.shared.wardrobeResponseInvite(response: .accept) { (_) in
        }
    }

    func didUserDenyWardrobe(with id: Int) {
        DataService.shared.wardrobeResponseInvite(response: .deny) { (_) in
        }
    }

}
