final class LookTableViewCellPresenter {
    weak var output: LookViewOutput?

    weak var cell: LookTableViewCell?

    private var index: Int

    init(index: Int) {
        self.index = index
    }

    public func deleteCollectionCell(index: Int) {
        cell?.deleteCollectionViewCell(index: index)
        output?.deleteViewModel(tableCellIndex: self.index, collectionCellIndex: index)
    }
}
