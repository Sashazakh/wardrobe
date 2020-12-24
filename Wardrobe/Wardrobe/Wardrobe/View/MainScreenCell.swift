import UIKit
import Kingfisher

class MainScreenCell: WardrobeCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    required init?(coder: NSCoder) {
        return nil
    }
    // MARK: Public functions

    func configureCell(with wardobeData: WardrobeData) {
        titleLable.text = wardobeData.name

        let url = URL(string: wardobeData.imageUrl ?? "")
        self.imageView.kf.setImage(with: url)
    }
}
