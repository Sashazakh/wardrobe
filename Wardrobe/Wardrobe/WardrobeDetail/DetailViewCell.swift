//
//  DetailViewCell.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 30.12.2020.
//

import UIKit
import PinLayout

class DetailViewCell: WardrobeCell {

    private weak var deleteMarkButton: UIButton!

    weak var output: WardrobeDetailViewOutput?

    private var lookId: Int?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }
    required init?(coder: NSCoder) {
        return nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutDeleteButtonLayout()
    }

    func setupViews() {
        setupDeleteButton()
    }
    // MAR: Setup views

    func setupDeleteButton() {
        let button = UIButton()

        deleteMarkButton = button
        imageView.addSubview(deleteMarkButton)

        deleteMarkButton.setImage(UIImage(systemName: "minus",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        deleteMarkButton.tintColor = GlobalColors.backgroundColor
        deleteMarkButton.addTarget(self, action: #selector(didTapDeleteMarkButton), for: .touchUpInside)
        deleteMarkButton.backgroundColor = GlobalColors.redCancelColor
        deleteMarkButton.layer.cornerRadius = 10
    }

    // MARK: Setup layout

    private func layoutDeleteButtonLayout() {
        deleteMarkButton.pin
            .top(3%)
            .right(3%)
            .width(20)
            .height(20)
    }

    private func checkDeleteButton() {
        if let output = output {
            if output.isEditButtonTapped() {
                deleteMarkButton.isHidden = false
            } else {
                deleteMarkButton.isHidden = true
            }
        }
    }

    // MARK: Public functions

    func configureCell(with look: WardrobeDetailData, output: WardrobeDetailViewOutput?) {
        titleLable.text = look.name

        let url = URL(string: look.imageUrl ?? "")
        self.imageView.kf.setImage(with: url)

        lookId = look.id

        self.output = output
        checkDeleteButton()
    }
    // MARK: User actions

    @objc private func didTapDeleteMarkButton(_ sender: Any) {
        guard let lookId = lookId else { return }

        output?.didDeleteLookTap(lookId: lookId)
    }
}
