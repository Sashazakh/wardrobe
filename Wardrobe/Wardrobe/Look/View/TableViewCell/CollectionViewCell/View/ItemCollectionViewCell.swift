import UIKit
import PinLayout
import Kingfisher

final class LookCollectionViewCell: WardrobeCell {

    private weak var deleteMarkButton: UIButton!

    var output: ItemCollectionViewCellPresenter?

    private var isEditing: Bool = false

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
        deleteMarkButton.isHidden = true
    }

    private func layoutDeleteMarkImageView() {
        if isEditing {
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

    public func setIsEditing(isEditing: Bool) {
        if isEditing {
            deleteMarkButton.isHidden = false
        }

        self.isEditing = isEditing

        setNeedsLayout()
        layoutIfNeeded()
    }

    public func configure(model: ItemData) {
        titleLable.text = model.clothesName
        if let url = model.imageURL {
            if let url = URL(string: (url) + "&apikey=\(AuthService.shared.getApiKey())") {
                self.imageView.contentMode = .scaleToFill
                self.imageView.kf.setImage(with: url)
            }
        } else {
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = GlobalConstants.deafultClothesImage
        }
    }

    @objc
    private func didTapDeleteMarkButton() {
        output?.didDeleteItem()
    }
}
