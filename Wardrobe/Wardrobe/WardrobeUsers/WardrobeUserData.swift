//
//  WardrobeUserData.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 31.12.2020.
//

import Foundation

class WardrobeUserData {
    let login: String
    let name: String
    let imageUrl: String?
    let imageId: Int?

    init(with user: WardrobeUserRaw) {
        self.login = user.login
        if let rawUrl = user.imageUrl {
            self.imageUrl = rawUrl + "&apikey=" + DataService.shared.getApiKey()
        } else {
            imageUrl = nil
        }
        self.name = user.userName

        self.imageId = user.imageId
    }
}
