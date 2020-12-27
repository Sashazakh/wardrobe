final class ItemCollectionViewCellPresenter {
    weak var output: LookTableViewCellPresenter?

    weak var cell: LookCollectionViewCell?

    private var index: Int

    init(index: Int) {
        self.index = index
    }

    public func didDeleteItem() {
        output?.deleteCollectionCell(index: index)
    }
}
