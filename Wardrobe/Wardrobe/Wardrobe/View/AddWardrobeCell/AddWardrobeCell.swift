import UIKit
import PinLayout

class AddWardrobeCell: UICollectionViewCell {
    static let identifier = "AddWardrobeCell"

    private weak var imageView: UIImageView!

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
    }

    // MARK: Setup views
    private func setupViews() {
        setupMainView()
        setupImageView()
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
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = GlobalColors.darkColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }

    // MARK: Setup layout

    private func setupImageViewLayout() {
        imageView.pin
            .center()
            .width(30%)
            .height(20%)
    }
}
