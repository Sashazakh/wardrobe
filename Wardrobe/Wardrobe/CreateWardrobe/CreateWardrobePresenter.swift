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

    private var imgData: Data?

    var userLogin: String?

    init(router: CreateWardrobeRouterInput, interactor: CreateWardrobeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CreateWardrobePresenter: CreateWardrobeViewOutput {
    func addWardrobe(name: String, description: String) {
        interactor.addWardrobe(with:
                                CreateWardobeData(name: name,
                                                  description: description,
                                                  imageData: imgData),
                               for: userLogin ?? "")
    }

    func didImageLoaded(image: Data) {
        imgData = image
    }

}

extension CreateWardrobePresenter: CreateWardrobeInteractorOutput {
    func successLoadWardobe() {
        view?.popView()
    }

    func showAlert(title: String, message: String) {
        view?.showALert(title: title, message: message)
    }

}
