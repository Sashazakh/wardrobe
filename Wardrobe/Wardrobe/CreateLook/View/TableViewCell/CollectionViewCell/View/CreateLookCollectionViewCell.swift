import UIKit
import PinLayout

final class CreateLookCollectionViewCell: WardrobeCell {

    private weak var stateButton: UIButton!

    var output: CreateLookCollectionViewCellPresenter?

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

        setCellStyle(isAdding: isAdding)

        guard let url = URL(string: (model.item.imageURL ?? String()) + "&apikey=\(AuthService.shared.getApiKey())") else {
            return
        }

        if model.needsToRefresh {
            imageView.kf.setImage(with: url, options: [.forceRefresh])
            output?.didRefreshCache()
        } else {
            imageView.kf.setImage(with: url)
        }
    }

    private func layoutDeleteMarkImageView() {
        stateButton.pin
            .top(3%)
            .right(3%)
            .width(20)
            .height(20)
    }

    private func setCellStyle(isAdding: Bool) {
        if !isAdding {
            stateButton.setImage(UIImage(systemName: "plus",
                                            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                            for: .normal)
            stateButton.backgroundColor = .systemGreen
            transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform.identity
            }
        } else {
            stateButton.setImage(UIImage(systemName: "minus",
                                            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                            for: .normal)
            stateButton.backgroundColor = UIColor(red: 240 / 255,
                                                  green: 98 / 255,
                                                  blue: 98 / 255,
                                                  alpha: 1)
            transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform.identity
            }
        }
    }

    @objc
    private func didTapStateButton() {
        isAdding = !isAdding
        setCellStyle(isAdding: isAdding)
        output?.changeSelection(isSelected: isAdding)
    }
}
