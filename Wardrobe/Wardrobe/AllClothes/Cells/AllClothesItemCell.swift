import Foundation
import UIKit
import PinLayout

class AllClothesItemCell: WardrobeCell {
    var output: AllClothesViewOutput?
    var collectionIndex: Int?
    var cellIndex: Int?
    var localModel: ItemData?
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

    @objc
    private func didTapDeleteMarkButton() {
        guard let localModel = localModel else { return }
        guard let collectionIndex = self.collectionIndex else { return }
        guard let cellIndex = self.cellIndex else { return }

        output?.deleteItem(id: localModel.clothesID, collectionIndex: collectionIndex, cellIndex: cellIndex)
    }

    func setData(data: ItemData, collectionIndex: Int, cellIndex: Int) {
        self.localModel = data
        self.collectionIndex = collectionIndex
        self.cellIndex = cellIndex
        self.titleLable.text = data.clothesName
        guard let url = URL(string: (data.imageURL ?? String()) + "&apikey=\(AuthService.shared.getApiKey())") else {
            return
        }
        self.imageView.kf.setImage(with: url, options: [.forceRefresh])
    }
}
