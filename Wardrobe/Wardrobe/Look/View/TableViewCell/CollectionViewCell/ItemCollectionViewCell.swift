import UIKit
import PinLayout

final class LookCollectionViewCell: UICollectionViewCell {

    private weak var itemImageView: UIImageView!

    private weak var itemLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCell()
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutItemImageView()
        layoutItemLabel()
    }

    private func setupCell() {
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
    }

    private func setupSubviews() {
        setupItemImageView()
        setupItemLabel()
    }

    private func setupItemImageView() {
        let imageView = UIImageView()

        itemImageView = imageView
        contentView.addSubview(itemImageView)

        itemImageView.image = UIImage(named: "morz")
    }

    private func setupItemLabel() {
        let label = UILabel()

        itemLabel = label
        contentView.addSubview(itemLabel)

        itemLabel.textAlignment = .center
        itemLabel.font = UIFont(name: "DMSans-Regular", size: 10)
        itemLabel.text = "Adidas"
    }

    private func layoutItemImageView() {
        itemImageView.pin
            .top(.zero)
            .left(.zero)
            .right(.zero)
            .bottom(50%)
    }

    private func layoutItemLabel() {
        itemLabel.pin
            .top(50%)
            .bottom(.zero)
            .width(90%)
            .hCenter()
    }
}
