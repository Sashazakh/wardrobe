final class AllItemsTableViewCellPresenter {
    weak var output: AllItemsViewOutput?

    weak var cell: AllItemsTableViewCell?

    private var index: Int

    init(index: Int) {
        self.index = index
    }

    public func changeSelection(collectionIndex: Int, isSelected: Bool) {
        output?.setSelection(categoryIndex: index, itemIndex: collectionIndex, isSelected: isSelected)
    }
}
