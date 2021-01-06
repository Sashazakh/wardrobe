import UIKit
import PinLayout

final class AllItemsCollectionViewCell: WardrobeCell {

    private weak var stateButton: UIButton!

    var output: AllItemsCollectionViewCellPresenter?

    private var isAdding: Bool = false

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

        stateButton = button
        imageView.addSubview(stateButton)

        stateButton.setImage(UIImage(systemName: "plus",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        stateButton.tintColor = GlobalColors.backgroundColor
        stateButton.addTarget(self, action: #selector(didTapStateButton), for: .touchUpInside)
        stateButton.backgroundColor = .systemGreen
        stateButton.layer.cornerRadius = 10
    }

    func configure(model: AllItemsCollectionViewCellViewModel) {
        titleLable.text = model.item.clothesName

        isAdding = model.isSelected

        if let url = model.item.imageURL {
            if let url = URL(string: (url) + "&apikey=\(AuthService.shared.getApiKey())") {
                self.imageView.contentMode = .scaleToFill
                if model.needsToRefresh {
                    imageView.kf.setImage(with: url, options: [.forceRefresh])
                    output?.didRefreshCache()
                } else {
                    imageView.kf.setImage(with: url)
                }
            }
        } else {
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = GlobalConstants.deafultClothesImage
        }
    }

    private func layoutDeleteMarkImageView() {
        if isAdding {
            stateButton.setImage(UIImage(systemName: "minus",
                                            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                            for: .normal)
            stateButton.backgroundColor = UIColor(red: 240 / 255,
                                                  green: 98 / 255,
                                                  blue: 98 / 255,
                                                  alpha: 1)
        } else {
            stateButton.setImage(UIImage(systemName: "plus",
                                            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                            for: .normal)
            stateButton.backgroundColor = .systemGreen
        }

        stateButton.pin
            .top(3%)
            .right(3%)
            .width(20)
            .height(20)
    }

    @objc
    private func didTapStateButton() {
        output?.changeSelection()
    }
}
