import UIKit
import PinLayout

class CreatorCell: UICollectionViewCell {
    static let identifier = "CreatorCell"

    private weak var avatarImageView: UIImageView!
    private weak var outerView: UIView!
    private weak var nameLabel: UILabel!

    weak var output: WardrobeUsersViewOutput?

    private var login: String?

    private var btnSize: CGFloat?

    private var userLogin: String?

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

        setupLayoutViews()
    }

    private func setupViews() {
        setupMainView()
        setupOuterView()
        setupImageView()
        setupNameLabel()
    }

    private func setupLayoutViews() {
        setupImageViewLayout()
        setupNameLabelLayout()
    }

    // MARK: Setup views
    private func setupMainView() {
        contentView.backgroundColor = .blue
        contentView.isUserInteractionEnabled = true
        contentView.backgroundColor = GlobalColors.backgroundColor
        contentView.layer.masksToBounds = true
    }

    private func setupOuterView() {
        let out = UIView()
        outerView = out
        outerView.isUserInteractionEnabled = false
        outerView.dropShadow()
        outerView.clipsToBounds = false
        contentView.addSubview(outerView)
    }

    private func setupImageView() {
        let imgView = UIImageView()
        avatarImageView = imgView
        avatarImageView.dropShadow()
        avatarImageView.contentMode = .scaleToFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 4
        avatarImageView.layer.borderColor = GlobalColors.backgroundColor.cgColor
        avatarImageView.backgroundColor = GlobalColors.backgroundColor
        outerView.addSubview(avatarImageView)
    }

    private func setupNameLabel() {
        let name = UILabel()
        nameLabel = name
        nameLabel.numberOfLines = 0
        nameLabel.textColor = GlobalColors.darkColor
        nameLabel.font = UIFont(name: "DMSans-Bold", size: 15)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.1
        nameLabel.numberOfLines = 0
        nameLabel.sizeToFit()
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
    }

    // MARK: Setup layout
    private func setupImageViewLayout() {
        let imgRadius = contentView.frame.height * 0.27
        outerView.pin
            .top(5%)
            .hCenter()
            .height(imgRadius * 2)
            .width(imgRadius * 2)

        avatarImageView.pin.all()
        avatarImageView.layer.cornerRadius = outerView.frame.height / 2
        outerView.layer.cornerRadius = outerView.frame.height / 2
    }

    private func setupNameLabelLayout() {
        nameLabel.pin
            .below(of: outerView)
            .marginTop(4%)
            .right()
            .left()
            .height(20%)
    }

    // MARK: Public functions
    func configureCell(wardrobeUser: WardrobeUserData,
                       output: WardrobeUsersViewOutput?) {
        login = wardrobeUser.login

        nameLabel.text = wardrobeUser.login
        userLogin = wardrobeUser.login

        if let url = URL(string: wardrobeUser.imageUrl ?? "") {
            self.avatarImageView.kf.setImage(with: url)
        } else {
            self.avatarImageView.image = UIImage(named: "no_photo")
        }

        self.output = output
        setNeedsLayout()
        layoutIfNeeded()
    }
}
