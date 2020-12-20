//
//  MainScreenProtocols.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 18.12.2020.
//  
//

import Foundation

protocol MainScreenViewInput: class {
}

protocol MainScreenViewOutput: class {
    func itemDidTap(at indexPath: IndexPath)
    func settingsButtonDidTap()
}

protocol MainScreenInteractorInput: class {
}

protocol MainScreenInteractorOutput: class {
}

protocol MainScreenRouterInput: class {
    func showDetailWardrope(id: Int)
    func showSettings()
}
