import UIKit
import PinLayout

final class CreateLookTableViewCell: UITableViewCell {

    private weak var sectionNameLabel: UILabel!

    private weak var itemCollectionView: UICollectionView!

    var output: CreateLookTableViewCellPresenter?

    private var itemModels: [AllItemsCollectionViewCellViewModel]?

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
        backgroundColor = .white
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
        sectionNameLabel.textColor = GlobalColors.darkColor
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

        itemCollectionView.register(CreateLookCollectionViewCell.self, forCellWithReuseIdentifier: "createLookCollectionViewCell")

        itemCollectionView.backgroundColor = .white
        itemCollectionView.showsHorizontalScrollIndicator = false
        itemCollectionView.showsVerticalScrollIndicator = false
    }

    private func layoutSectionNameLabel() {
        sectionNameLabel.pin
            .top(1%)
            .left(2%)
            .height(30)
            .width(80%)
    }

    private func layoutCollectionView() {
        itemCollectionView.pin
            .top(sectionNameLabel.frame.maxY)
            .width(100%)
            .bottom(.zero)

        if let flowLayout = itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = GlobalConstants.cellSize
            flowLayout.sectionInset = UIEdgeInsets(top: .zero,
                                                   left: 5,
                                                   bottom: .zero,
                                                   right: 5)
        }
    }

    public func configure(model: AllItemsTableViewCellViewModel) {
        sectionNameLabel.text = model.sectionName
        itemModels = model.itemModels
        itemCollectionView.reloadData()
    }
}

extension CreateLookTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        UIView.animate(withDuration: 0.5) {
            cell.transform = CGAffineTransform.identity
        }
    }
}

extension CreateLookTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemModels?.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "createLookCollectionViewCell",
                                                            for: indexPath) as? CreateLookCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.dropShadow()

        guard let models = itemModels else {
            return cell
        }

        let cellPresenter = CreateLookCollectionViewCellPresenter(index: indexPath.row)

        cellPresenter.cell = cell
        cellPresenter.output = output
        cell.output = cellPresenter
        cell.configure(model: models[indexPath.row])

        return cell
    }
}
