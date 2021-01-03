//
//  NewItemScreenInteractor.swift
//  Wardrobe
//
//  Created by kymblc on 18.12.2020.
//  
//

import Foundation

final class NewItemScreenInteractor {
	weak var output: NewItemScreenInteractorOutput?

    private var category: String

    init(category: String) {
        self.category = category
    }
}

extension NewItemScreenInteractor: NewItemScreenInteractorInput {
}
