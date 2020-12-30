//
//  MyInvitesCell.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 28.12.2020.
//

import UIKit
import PinLayout

class MyInvitesCell: UITableViewCell {
    static let identifier = "MyInvitesCell"

    private weak var mainView: UIView!
    private weak var wardobeImageView: UIImageView!
    private weak var infoLabel: UILabel!

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
        setupContentView()
        setupMainView()
        setupImageView()
        setupInfoLabel()
    }

    private func setupLayout() {
        setupMainViewLayout()
        setupImageViewLayout()
        setupInfoLabelLayout()
    }

    // MARK: Setupping cells
    private func setupContentView() {
        contentView.backgroundColor = GlobalColors.backgroundColor
    }

    private func setupMainView() {
        let main = UIView()
        mainView = main
        mainView.backgroundColor = GlobalColors.backgroundColor
        mainView.dropShadow()
        mainView.layer.cornerRadius = Constants.cornerRadius
        contentView.addSubview(mainView)
    }

    private func setupImageView() {
        let image = UIImageView()
        wardobeImageView = image
        wardobeImageView.image = UIImage(named: "morz")
        wardobeImageView.contentMode = .scaleToFill
        wardobeImageView.clipsToBounds = true
        wardobeImageView.layer.cornerRadius = Constants.cornerRadius
        wardobeImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        mainView.addSubview(wardobeImageView)
    }

    private func setupInfoLabel() {
        let infLabel = UILabel()
        infoLabel = infLabel
        infoLabel.textColor = GlobalColors.darkColor
        infoLabel.font = UIFont(name: "DMSans-Regular", size: 15)
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.minimumScaleFactor = 0.1
        infoLabel.numberOfLines = 0
        infoLabel.sizeToFit()
        infoLabel.textAlignment = .center
        infoLabel.layer.cornerRadius = Constants.cornerRadius
        infoLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        infoLabel.clipsToBounds = true
        mainView.addSubview(infoLabel)
    }
    // MARK: Layout

    private func setupMainViewLayout() {
        mainView.pin
            .width(95%)
            .height(85%)
            .center()
    }

    private func setupImageViewLayout() {
        wardobeImageView?.pin
            .right()
            .top()
            .bottom()
            .width(30%)
    }

    private func setupInfoLabelLayout() {
        infoLabel.pin
            .before(of: wardobeImageView)
            .marginRight(5)
            .top()
            .left()
            .bottom()
    }
    // MARK: Public functions

    func configureCell(userLogin: String, wardrobeName: String, imageUrl: URL?) {
        let resultString = userLogin + Constants.constText + wardrobeName
        infoLabel.text = resultString
    }
}

extension MyInvitesCell {
    struct Constants {
        static let cornerRadius: CGFloat = 10
        static let constText: String = " приглашает \n вас в гардероб\n"
    }
}
