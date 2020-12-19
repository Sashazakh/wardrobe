//
//  CreateWardrobePresenter.swift
//  Wardrobe
//
//  Created by kymblc on 19.12.2020.
//  
//

import Foundation
import UIKit

final class CreateWardrobePresenter {
	weak var view: CreateWardrobeViewInput?

	private let router: CreateWardrobeRouterInput
	private let interactor: CreateWardrobeInteractorInput

    init(router: CreateWardrobeRouterInput, interactor: CreateWardrobeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CreateWardrobePresenter: CreateWardrobeViewOutput {
    func didImageLoaded(image: UIImage) {
        debugPrint("Got image \(image.description)")
    }

}

extension CreateWardrobePresenter: CreateWardrobeInteractorOutput {
}
