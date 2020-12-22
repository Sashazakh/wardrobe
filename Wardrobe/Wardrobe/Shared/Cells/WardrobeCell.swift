import UIKit
import PinLayout

class WardrobeCell: UICollectionViewCell {
    static let identifier = "WardrobeCell"

    private weak var imageView: UIImageView!
    private weak var titleLable: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setupImageViewLayout()
        setupTitleLabelLayout()
    }

    // MARK: Setup views
    private func setupViews() {
        setupMainView()
        setupImageView()
        setupTitleLabel()
    }

    private func setupMainView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        dropShadow()
        contentView.backgroundColor = GlobalColors.backgroundColor
    }

    private func setupImageView() {
        let imgView = UIImageView()
        imageView = imgView
        imageView.image = UIImage(named: "morz")
        imageView.contentMode = .scaleToFill//.scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }

    private func setupTitleLabel() {
        let label = UILabel()
        titleLable = label
        titleLable.text = "Переговоры с боссом"
        titleLable.textColor = GlobalColors.darkColor
        titleLable.font = UIFont(name: "DMSans-Bold", size: 15)
        titleLable.adjustsFontSizeToFitWidth = true
        titleLable.minimumScaleFactor = 0.1
        titleLable.numberOfLines = 0
        titleLable.sizeToFit()
        titleLable.textAlignment = .center
        contentView.addSubview(titleLable)
    }

    // MARK: Setup layout

    private func setupImageViewLayout() {
        imageView.pin
            .top()
            .left()
            .right()
            .height(66%)
    }

    private func setupTitleLabelLayout() {
        titleLable.pin
            .below(of: imageView)
            .left()
            .right()
            .margin(5%)
            .bottom()
            //.marginBottom(5%)
    }
}
