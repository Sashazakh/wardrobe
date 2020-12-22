import Foundation
import PinLayout

class AddUserCell: UICollectionViewCell {
    static let identifier = "AddUserCell"

    private weak var outerView: UIView!
    private weak var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setupLayout()
    }

    private func setupViews() {
        setupMainView()
        setupOuterView()
        setupImageView()
    }

    private func setupLayout() {
        setupImageViewLayout()
    }

    // MARK: Setupping views

    private func setupMainView() {
        contentView.layer.masksToBounds = true
    }

    private func setupOuterView() {
        let out = UIView()
        outerView = out
        outerView.dropShadow()
        outerView.clipsToBounds = false
        outerView.backgroundColor = GlobalColors.tintColor
        contentView.addSubview(outerView)
    }

    private func setupImageView() {
        let imgView = UIImageView()
        imageView = imgView
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = GlobalColors.darkColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        outerView.addSubview(imageView)
    }

    // MARK: Setup layout

    private func setupImageViewLayout() {
        let imgRadius = contentView.frame.height * 0.27
        outerView.pin
            .top(5%)
            .hCenter()
            .height(imgRadius * 2)
            .width(imgRadius * 2)

        imageView.pin
            .center()
            .width(50%)
            .height(50%)
        outerView.layer.cornerRadius = outerView.frame.height / 2
        imageView.layer.cornerRadius = outerView.frame.height / 2
    }
}
