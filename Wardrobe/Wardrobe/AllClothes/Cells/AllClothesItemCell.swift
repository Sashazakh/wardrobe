import Foundation
import UIKit
import PinLayout

class AllClothesItemCell: WardrobeCell {
    var output: AllClothesViewOutput?
    var localModel: ItemData?
    var visible: Bool = false
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

       // layoutDeleteMarkImageView()
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
        visible = true
    }
    private func delayoutDeleteMarkImageView() {
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
        visible = false
    }

    public func setIsEditing(isEditing: Bool) {
        if isEditing {
            deleteMarkButton.isHidden = false
            layoutDeleteMarkImageView()
        } else {
            if visible {
                delayoutDeleteMarkImageView()
            }

        }
    }

    @objc
    private func didTapDeleteMarkButton() {
        guard let localModel = localModel else { return }

        output?.deleteItem(id: localModel.clothesID)
    }

    func setData(data: ItemData, needForceRefresh: Bool = true) {
        self.localModel = data
        self.titleLable.text = data.clothesName
        if let url = data.imageURL {
            if let url = URL(string: (url) + "&apikey=\(AuthService.shared.getApiKey())") {
                self.imageView.contentMode = .scaleToFill
                if needForceRefresh {
                    self.imageView.kf.setImage(with: url, options: [.forceRefresh])
                } else {
                    self.imageView.kf.setImage(with: url)
                }
            }
        } else {
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = GlobalConstants.deafultClothesImage
        }
    }
}
