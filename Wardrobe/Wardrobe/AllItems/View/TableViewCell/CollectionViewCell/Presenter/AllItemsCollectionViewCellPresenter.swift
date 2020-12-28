final class AllItemsCollectionViewCellPresenter {
    weak var output: AllItemsTableViewCellPresenter?

    weak var cell: AllItemsCollectionViewCell?

    private var index: Int

    init(index: Int) {
        self.index = index
    }

    public func changeSelection(isSelected: Bool) {
        output?.changeSelection(collectionIndex: index, isSelected: isSelected)
    }
}
