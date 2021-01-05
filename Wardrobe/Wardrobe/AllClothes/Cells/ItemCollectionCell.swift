import Foundation
import UIKit
import PinLayout

final class ItemCollectionCell: UITableViewCell {
    private weak var itemCollectionView: UICollectionView!
    private weak var collectionLabel: UILabel!
    private weak var addButton: UIButton!
    var output: AllClothesViewOutput?
    var localModel: CategoryData?
    var editMode: Bool?
    var index: Int?
    private let screenBounds = UIScreen.main.bounds

    func setData(output: AllClothesViewOutput, index: Int, editMode: Bool) {
        self.output = output
        self.editMode = editMode
        self.index = index
        readTitle()
        readModel()
        self.itemCollectionView.reloadData()
    }

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

    private func readTitle() {
        guard let index = self.index else { return }
        collectionLabel.text = output?.getTitle(for: index)
    }

    private func readModel() {
        guard let index = self.index else { return }
        guard let output = self.output else { return }
        self.localModel = output.getCategory(for: index)
    }

    func reloadData() {
        itemCollectionView?.reloadData()
    }

    @objc private func didTapAddButton() {
        output?.didTapAddItem(category: localModel?.categoryName ?? "")
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
        layoutCollectionLabel()
        layoutItemCollectionView()
        layoutAddButton()
    }

    // MARK: collectionLabel

    private func setupCollectionLabel() {
        let label = UILabel()
        collectionLabel = label
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

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }

        itemCollectionView = collectionView
        itemCollectionView.backgroundColor = .clear
        itemCollectionView.showsHorizontalScrollIndicator = false
        itemCollectionView.register(AllClothesItemCell.self, forCellWithReuseIdentifier: AllClothesItemCell.identifier)

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

        if let flowLayout = itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = GlobalConstants.cellSize
            flowLayout.sectionInset = UIEdgeInsets(top: .zero,
                                                   left: 5,
                                                   bottom: .zero,
                                                   right: 5)
        }
    }
    // MARK: addButton

    private func setupAddButton() {
        let button = UIButton()
        addButton = button
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = GlobalColors.backgroundColor
        addButton.backgroundColor = GlobalColors.mainBlueScreen
        addButton.addTarget(self, action: #selector(self.didTapAddButton), for: .touchUpInside)
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
}

extension ItemCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.localModel?.items.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = localModel?.items[indexPath.row] else { return }
        guard let editMode = self.editMode else { return }
        if editMode {
            output?.didTapItem(itemId: data.clothesID)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)
        -> CGSize {
        return GlobalConstants.cellSize
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.4) {
                cell.transform = CGAffineTransform.identity
            }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllClothesItemCell.identifier, for: indexPath)
                as? AllClothesItemCell else { return UICollectionViewCell() }
        guard let data = localModel?.items[indexPath.row] else { return UICollectionViewCell() }
        guard let mode = self.editMode else { return UICollectionViewCell() }
        cell.output = output
        cell.setData(data: data, needForceRefresh: isEditing)
        cell.setIsEditing(isEditing: mode)
        return cell
    }

}
