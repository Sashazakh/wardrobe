final class AllItemsCollectionViewCellPresenter {
    weak var output: AllItemsTableViewCellPresenter?

    weak var cell: AllItemsCollectionViewCell?

    private var index: Int

    init(index: Int) {
        self.index = index
    }

    public func changeSelection() {
        output?.changeSelection(collectionIndex: index)
    }

    public func didRefreshCache() {
        output?.didRefreshCache(collectionIndex: index)
    }
}
