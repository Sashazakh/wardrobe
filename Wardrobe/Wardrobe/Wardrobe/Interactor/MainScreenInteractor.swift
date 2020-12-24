//
//  MainScreenInteractor.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 18.12.2020.
//  
//

import Foundation

final class MainScreenInteractor {
	weak var output: MainScreenInteractorOutput?

    private func handleError(with error: Error) {

    }

    private func handleWardrobes(with wardrobeRaw: [WardrobeRaw]) {

    }
}

extension MainScreenInteractor: MainScreenInteractorInput {
    func loadUserWardobes() {
        DataService.shared.getUserWardrobes { [weak self] result in
            guard let self = self else { return }

            if let error = result.error {
                self.handleError(with: error)
                return
            }

            guard let wardobes = result.data else {
                return
            }

            self.handleWardrobes(with: wardobes)
        }
    }

}
