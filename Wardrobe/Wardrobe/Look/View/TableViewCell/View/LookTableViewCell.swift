import UIKit
import PinLayout

final class LookTableViewCell: UITableViewCell {

    private weak var sectionNameLabel: UILabel!

    private weak var itemCollectionView: UICollectionView!

    var output: LookTableViewCellPresenter?

    private var itemsAreEditing: Bool = false

    private var animate: [Bool]?

    private var itemModels: [ItemCollectionViewCellViewModel]?

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

        itemCollectionView.register(LookCollectionViewCell.self,
                                    forCellWithReuseIdentifier: "itemCell")

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

    public func setIsEditing(isEditing: Bool) {
        if isEditing != itemsAreEditing {
            itemsAreEditing = isEditing
        }
    }

    public func configure(viewModel: LookTableViewCellViewModel) {
        sectionNameLabel.text = viewModel.sectionName
        itemModels = viewModel.itemModels
        animate = [Bool](repeating: false, count: viewModel.itemModels.count)
        itemCollectionView.reloadData()
    }

    public func deleteCollectionViewCell(index: Int) {
        let indexPath = IndexPath(row: index, section: .zero)

        animate = [Bool](repeating: false, count: (itemModels?.count ?? 1) - 1)
        itemCollectionView.deleteItems(at: [indexPath])
        itemModels?.remove(at: index)
    }
}

extension LookTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if animate?[indexPath.row] ?? false {
            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            UIView.animate(withDuration: 0.5) {
                cell.transform = CGAffineTransform.identity
            }
        } else {
            animate?[indexPath.row] = true
        }
    }
}

extension LookTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemModels?.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as? LookCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setIsEditing(isEditing: itemsAreEditing)
        cell.dropShadow()

        guard let models = itemModels else {
            return cell
        }

        let cellPresenter = ItemCollectionViewCellPresenter(index: indexPath.row)

        cellPresenter.cell = cell
        cellPresenter.output = output
        cell.output = cellPresenter
        cell.configure(model: models[indexPath.row].item)

        return cell
    }
}
