//
//  NewItemScreenPresenter.swift
//  Wardrobe
//
//  Created by kymblc on 18.12.2020.
//  
//

import Foundation
import UIKit

final class NewItemScreenPresenter {
	weak var view: NewItemScreenViewInput?

	private let router: NewItemScreenRouterInput
	private let interactor: NewItemScreenInteractorInput

    init(router: NewItemScreenRouterInput, interactor: NewItemScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension NewItemScreenPresenter: NewItemScreenViewOutput {
    func didImageLoaded(image: UIImage) {
        debugPrint("Got image \(image.description)")
    }

}

extension NewItemScreenPresenter: NewItemScreenInteractorOutput {
}
