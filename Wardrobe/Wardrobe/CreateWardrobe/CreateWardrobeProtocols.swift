//
//  CreateWardrobeProtocols.swift
//  Wardrobe
//
//  Created by kymblc on 19.12.2020.
//  
//

import Foundation
import UIKit

protocol CreateWardrobeViewInput: class {
    func showALert(title: String, message: String)
    func popView()
}

protocol CreateWardrobeViewOutput: class {
    func didImageLoaded(image: Data)
    func addWardrobe(name: String, description: String)
}

protocol CreateWardrobeInteractorInput: class {
    func addWardrobe(with wardobe: CreateWardobeData, for user: String)
}

protocol CreateWardrobeInteractorOutput: class {
    func showAlert(title: String, message: String)
    func successLoadWardobe()
}

protocol CreateWardrobeRouterInput: class {
}
