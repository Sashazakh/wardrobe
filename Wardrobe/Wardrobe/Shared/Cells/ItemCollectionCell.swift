import Foundation
import UIKit
import PinLayout

final class ItemCollectionCell: UITableViewCell {
    private weak var itemCollectionView: UICollectionView!
    private weak var collectionLabel: UILabel!
    private weak var addButton: UIButton!
    private let screenBounds = UIScreen.main.bounds

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
    }
}

extension ItemCollectionCell {
    private func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = GlobalColors.backgroundColor
        setupCollectionLabel()
        setupItemCollectionView()
        setupAddButton()
    }

    private func layoutUI() {
        layoutView()
        layoutCollectionLabel()
        layoutItemCollectionView()
        layoutAddButton()
    }

    // MARK: collectionLabel

    private func setupCollectionLabel() {
        let label = UILabel()
        collectionLabel = label
        collectionLabel.text = "Проверка"
        collectionLabel.textColor = GlobalColors.darkColor
        collectionLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        addSubview(collectionLabel)
    }

    private func layoutCollectionLabel() {
        collectionLabel.pin
            .top()
            .left(10)
            .sizeToFit()
    }

    // MARK: itemCollectionView

    private func setupItemCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        itemCollectionView = collectionView
        itemCollectionView.backgroundColor = .clear
        itemCollectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        itemCollectionView.showsHorizontalScrollIndicator = false
        itemCollectionView.register(WardrobeCell.self, forCellWithReuseIdentifier: WardrobeCell.identifier)
        if let flowLayout = itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let marginSides = screenBounds.width * 0.053
            let marginBottom = screenBounds.height * 0.023
            flowLayout.minimumInteritemSpacing = marginBottom
            flowLayout.minimumLineSpacing = marginSides
            flowLayout.scrollDirection = .horizontal
        }
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        contentView.addSubview(itemCollectionView)
    }

    private func layoutItemCollectionView() {
        itemCollectionView.pin
            .below(of: collectionLabel)
            .left()
            .right()
            .bottom()
    }
    // MARK: addButton

    private func setupAddButton() {
        let button = UIButton()
        addButton = button
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = GlobalColors.backgroundColor
        addButton.backgroundColor = GlobalColors.mainBlueScreen
        contentView.addSubview(addButton)
    }

    private func layoutAddButton() {
        let square = collectionLabel.frame.height * 0.6
        addButton.pin
            .after(of: collectionLabel, aligned: .center).marginLeft(5)
            .height(square)
            .width(square)

        addButton.layer.cornerRadius = addButton.frame.width / 2
        addButton.dropShadow(offset: CGSize(width: 0, height: 2), radius: 2, opacity: 0.4)
    }

    // MARK: Hacker techniques
    private func layoutView() {
        self.pin
//            .left(10)
//            .right(10)
        // self.dropShadow()
    }

}

extension ItemCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)
        -> CGSize {
        let cellWidth = screenBounds.width * 0.37 * 0.9
        let cellHeight = cellWidth * 2//self.bounds.height * 0.7//screenBounds.height * 0.2216
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.4) {
                cell.transform = CGAffineTransform.identity
            }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WardrobeCell.identifier, for: indexPath)
        return cell
    }

}