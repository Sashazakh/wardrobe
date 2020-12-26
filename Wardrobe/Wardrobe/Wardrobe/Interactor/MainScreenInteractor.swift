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
        print(error)

    }

    private func handleWardrobes(with wardrobeRaw: [WardrobeRaw]) {
        let wardobes: [WardrobeData] = wardrobeRaw.map({ WardrobeData(with: $0) })
        output?.didReceive(with: wardobes)
    }
}

extension MainScreenInteractor: MainScreenInteractorInput {
    func loadUserWardobes(for user: String) {
        DataService.shared.getUserWardrobes(for: user) { [weak self] result in
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
