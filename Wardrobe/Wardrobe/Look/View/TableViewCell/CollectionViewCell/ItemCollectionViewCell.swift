import UIKit
import PinLayout
import Kingfisher

final class LookCollectionViewCell: WardrobeCell {

    private weak var deleteMarkButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutDeleteMarkImageView()
    }

    private func setupSubviews() {
        setupDeleteMarkImageView()
    }

    private func setupDeleteMarkImageView() {
        let button = UIButton()

        deleteMarkButton = button
        imageView.addSubview(deleteMarkButton)

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

    public func configure(model: ItemData) {
        titleLable.text = model.clothesName
        guard let url = URL(string: "http://194.58.123.93:3000/getImage?id=7&apikey=be3380626a9d5a44c3ef2737717d4e64") else {
            return
        }

        self.imageView.kf.setImage(with: url)
    }

    @objc
    private func didTapDeleteMarkButton() {

    }
}
