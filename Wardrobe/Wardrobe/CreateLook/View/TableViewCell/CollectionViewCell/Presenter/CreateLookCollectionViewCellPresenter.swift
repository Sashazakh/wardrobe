final class CreateLookCollectionViewCellPresenter {
    weak var output: CreateLookTableViewCellPresenter?

    weak var cell: CreateLookCollectionViewCell?

    private var index: Int

    init(index: Int) {
        self.index = index
    }

    public func changeSelection(isSelected: Bool) {
        output?.changeSelection(collectionIndex: index, isSelected: isSelected)
    }

    public func didRefreshCache() {
        output?.didRefreshCache(collectionIndex: index)
    }
}
