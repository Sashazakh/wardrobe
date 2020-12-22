import UIKit
import PinLayout

final class LookCollectionViewCell: UICollectionViewCell {

    private weak var itemImageView: UIImageView!

    private weak var deleteMarkButton: UIButton!

    private weak var itemLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCell()
        setupSubviews()
        setupDeleteMarkImageView()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutItemImageView()
        layoutItemLabel()
        layoutDeleteMarkImageView()
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
        itemImageView.isUserInteractionEnabled = true
    }

    private func setupItemLabel() {
        let label = UILabel()

        itemLabel = label
        contentView.addSubview(itemLabel)

        itemLabel.textAlignment = .center
        itemLabel.font = UIFont(name: "DMSans-Regular", size: 10)
        itemLabel.text = "Adidas"
    }

    private func setupDeleteMarkImageView() {
        let button = UIButton()

        deleteMarkButton = button
        itemImageView.addSubview(deleteMarkButton)

        // deleteMarkButton.isHidden = true
        deleteMarkButton.setImage(UIImage(systemName: "minus",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        deleteMarkButton.tintColor = GlobalColors.backgroundColor
        deleteMarkButton.addTarget(self, action: #selector(didTapDeleteMarkButton), for: .touchUpInside)
        deleteMarkButton.backgroundColor = UIColor(red: 240 / 255,
                                                   green: 98 / 255,
                                                   blue: 98 / 255,
                                                   alpha: 1)
        deleteMarkButton.layer.cornerRadius = 10
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

    private func layoutDeleteMarkImageView() {
        deleteMarkButton.pin
            .top(3%)
            .right(3%)
            .width(20)
            .height(20)
    }

    public func setIsEditing(isEditing: Bool) {
        if isEditing {
            deleteMarkButton.isHidden = false
        } else {
            deleteMarkButton.isHidden = true
        }
    }

    @objc
    private func didTapDeleteMarkButton() {

    }
}
