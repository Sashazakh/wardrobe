//
//  DetailViewCell.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 30.12.2020.
//

import Foundation
import UIKit

class DetailViewCell: WardrobeCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    required init?(coder: NSCoder) {
        return nil
    }
    // MARK: Public functions

    func configureCell(with look: WardrobeDetailData) {
        titleLable.text = look.name

        let url = URL(string: look.imageUrl ?? "")
        self.imageView.kf.setImage(with: url)
    }
}
