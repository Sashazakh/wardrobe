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

    private var lookModel: WardrobeDetailData?

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
        deleteMarkButton.isHidden = true
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
                UIView.animate(withDuration: 0, animations: {
                    self.deleteMarkButton.pin
                        .top(3%)
                        .right(7%)
                        .width(10)
                        .height(10)
                    self.deleteMarkButton.alpha = 0
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.deleteMarkButton.pin
                            .top(3%)
                            .right(3%)
                            .width(20)
                            .height(20)
                        self.deleteMarkButton.alpha = 1
                    })
                })
                deleteMarkButton.isHidden = false
            } else {
                UIView.animate(withDuration: 0, animations: {
                    self.deleteMarkButton.pin
                        .top(3%)
                        .right(3%)
                        .width(20)
                        .height(20)
                    self.deleteMarkButton.alpha = 1
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.deleteMarkButton.pin
                            .top(3%)
                            .right(3%)
                            .width(0)
                            .height(0)
                        self.deleteMarkButton.alpha = 0
                    }, completion: { (_) in
                        self.deleteMarkButton.isHidden = true
                    })
                })
            }
        }
    }

    // MARK: Public functions

    func configureCell(with look: WardrobeDetailData,
                       output: WardrobeDetailViewOutput?) {
        titleLable.text = look.name

        let url = URL(string: look.imageUrl ?? "")
        self.imageView.kf.setImage(with: url)
        lookId = look.id

        self.output = output
        checkDeleteButton()
        lookModel = look
    }
    // MARK: User actions

    @objc private func didTapDeleteMarkButton(_ sender: Any) {
        guard let lookModel = lookModel else { return }

        output?.didDeleteLookTap(with: lookModel)
    }
}
