//
//  DropTableCell.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 01.01.2021.
//

import UIKit
import PinLayout

class DropTableCell: UITableViewCell {
    static let identifier = "DropTableCell"

    private weak var icon: UIImageView!
    private weak var cellLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setupLayout()
    }

    private func setupViews() {
        setupMainView()
        setupIcon()
        setupLabel()
    }

    private func setupMainView() {
        contentView.backgroundColor = GlobalColors.backgroundColor
        isUserInteractionEnabled = true
        self.selectionStyle = .none
    }

    private func setupLayout() {
        setupIconLayout()
        setupCellLabelLayout()
    }

    // MARK: Setup views

    private func setupIcon() {
        let icn = UIImageView()
        icon = icn
        icon.contentMode = .scaleToFill
        icon.clipsToBounds = true
        icon.tintColor = GlobalColors.darkColor
        contentView.addSubview(icon)
    }

    private func setupLabel() {
        let lbl = UILabel()
        cellLabel = lbl
        cellLabel.textColor = GlobalColors.darkColor
        cellLabel.font = UIFont(name: "DMSans-Bold", size: 14)
        cellLabel.adjustsFontSizeToFitWidth = true
        cellLabel.minimumScaleFactor = 0.1
        cellLabel.numberOfLines = 0
        cellLabel.sizeToFit()
        contentView.addSubview(cellLabel)
    }

    // MARK: SetupLayout

    private func setupIconLayout() {
        icon.pin
            .vCenter()
            .left(Constants.iconMatginLeft)
            .height(Constants.iconHeight)
            .width(Constants.iconWidth)
    }

    private func setupCellLabelLayout() {
        cellLabel.pin
            .after(of: icon, aligned: .center)
            .marginLeft(Constants.cellMarginLeft)
            .height(60%)
            .width(80%)
            .right(5)
    }

    // MARK: Public func

    public func configureCell(icon: UIImage, label: String) {
        self.icon.image = icon
        self.cellLabel.text = label
    }
}

extension DropTableCell {
    struct Constants {
        static let iconWidth: CGFloat = 18
        static let iconHeight: CGFloat = 18
        static let cellMarginLeft: CGFloat = 10
        static let iconMatginLeft: CGFloat = 15
    }
}
