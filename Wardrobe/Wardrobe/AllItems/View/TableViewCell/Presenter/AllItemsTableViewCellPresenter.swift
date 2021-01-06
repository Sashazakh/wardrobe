final class AllItemsTableViewCellPresenter {
    weak var output: AllItemsViewOutput?

    weak var cell: AllItemsTableViewCell?

    private var index: Int

    init(index: Int) {
        self.index = index
    }

    public func changeSelection(collectionIndex: Int) {
        output?.setSelection(categoryIndex: index, itemIndex: collectionIndex)
    }

    public func didRefreshCache(collectionIndex: Int) {
        output?.didRefreshed(categoryIndex: index, itemIndex: collectionIndex)
    }
}
