final class CreateLookTableViewCellPresenter {
    weak var output: CreateLookViewOutput?

    weak var cell: CreateLookTableViewCell?

    private var index: Int

    init(index: Int) {
        self.index = index
    }

    public func changeSelection(collectionIndex: Int, isSelected: Bool) {
        output?.setSelection(categoryIndex: index, itemIndex: collectionIndex, isSelected: isSelected)
    }

    public func didRefreshCache(collectionIndex: Int) {
        output?.didRefreshCache(categoryIndex: index, itemIndex: collectionIndex)
    }
}
