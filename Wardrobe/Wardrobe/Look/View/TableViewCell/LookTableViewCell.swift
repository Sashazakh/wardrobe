import UIKit
import PinLayout

final class LookTableViewCell: UITableViewCell {

    private weak var sectionNameLabel: UILabel!

    private weak var itemCollectionView: UICollectionView!

    private var itemsAreEditing: Bool = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutSectionNameLabel()
        layoutCollectionView()
    }

    private func setupView() {
    }

    private func setupSubviews() {
        setupSectionNameLabel()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    private func setupSectionNameLabel() {
        let label = UILabel()

        sectionNameLabel = label
        contentView.addSubview(sectionNameLabel)

        sectionNameLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        sectionNameLabel.textAlignment = .left
        sectionNameLabel.text = "Тапки"
    }

    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()

        flowLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: flowLayout)

        itemCollectionView = collectionView
        contentView.addSubview(itemCollectionView)

        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self

        itemCollectionView.register(LookCollectionViewCell.self, forCellWithReuseIdentifier: "itemCell")

        itemCollectionView.backgroundColor = .white
        itemCollectionView.showsHorizontalScrollIndicator = false
        itemCollectionView.showsVerticalScrollIndicator = false
    }

    private func layoutSectionNameLabel() {
        sectionNameLabel.pin
            .top(1%)
            .left(2%)
            .height(30)
            .width(50%)
    }

    private func layoutCollectionView() {
        itemCollectionView.pin
            .top(sectionNameLabel.frame.maxY)
            .width(100%)
            .bottom(.zero)

        if let flowLayout = itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 20 - 10) / 3,
                                         height: (UIScreen.main.bounds.width - 20 - 10) / 3)
            flowLayout.sectionInset = UIEdgeInsets(top: .zero,
                                                   left: 5,
                                                   bottom: .zero,
                                                   right: 5)
        }
    }

    public func setIsEditing(isEditing: Bool) {
        if isEditing != itemsAreEditing {
            itemsAreEditing = isEditing
            itemCollectionView.reloadData()
        }
    }
}

extension LookTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
}

extension LookTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as? LookCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setIsEditing(isEditing: itemsAreEditing)
        cell.dropShadow()

        return cell
    }
}
