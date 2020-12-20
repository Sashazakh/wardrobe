import UIKit
import PinLayout

class WardrobeUsersCell: UICollectionViewCell {
    static let identifier = "WardrobeUsersCell"

    private weak var imageView: UIImageView!
    private weak var outerView: UIView!
    private weak var nameLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setupLayoutViews()
    }

    private func setupViews() {
        setupMainView()
        setupOuterView()
        setupImageView()
        setupNameLabel()
    }

    private func setupLayoutViews() {
        setupImageViewLayout()
        setupNameLabelLayout()
    }

    // MARK: Setup views

    private func setupMainView() {
        contentView.backgroundColor = GlobalColors.backgroundColor
    }

    private func setupOuterView() {
        let out = UIView()
        outerView = out
        outerView.dropShadow()
        outerView.clipsToBounds = false
        outerView.layer.borderWidth = 4
        outerView.layer.borderColor = GlobalColors.backgroundColor.cgColor
        contentView.addSubview(outerView)
    }

    private func setupImageView() {
        let imgView = UIImageView()
        imageView = imgView
        imageView.image = UIImage(named: "morz")
        imageView.tintColor = GlobalColors.darkColor
        imageView.contentMode = .scaleToFill
        imageView.dropShadow()
        imageView.clipsToBounds = true
        outerView.addSubview(imageView)
    }

    private func setupNameLabel() {
        let name = UILabel()
        nameLabel = name
        nameLabel.numberOfLines = 2
        nameLabel.text = "Морж \nМоржов Моржович"
        nameLabel.textColor = GlobalColors.darkColor
        nameLabel.font = UIFont(name: "DMSans-Bold", size: 15)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.1
        nameLabel.numberOfLines = 0
        nameLabel.sizeToFit()
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
    }

    // MARK: Setup layout

    private func setupImageViewLayout() {
        outerView.pin
            .top()
            .right()
            .left()
            .height(66%)

        imageView.pin
            .center()
            .height(outerView.frame.height)
            .width(outerView.frame.width)
        outerView.layer.cornerRadius = outerView.frame.height / 2
        imageView.layer.cornerRadius = outerView.frame.height / 2
    }

    private func setupNameLabelLayout() {
        nameLabel.pin
            .below(of: outerView, aligned: .center)
            .marginTop(7%)
            .sizeToFit()
    }
}
