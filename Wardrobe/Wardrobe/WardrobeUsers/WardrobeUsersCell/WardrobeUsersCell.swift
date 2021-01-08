import UIKit
import PinLayout

class WardrobeUsersCell: UICollectionViewCell {
    static let identifier = "WardrobeUsersCell"

    private weak var avatarImageView: UIImageView!
    private weak var outerView: UIView!
    private weak var nameLabel: UILabel!
    private weak var deleteButton: DeleteButton!

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
        checkDeleteButton()
    }

    private func setupViews() {
        setupDeleteButton()
        setupMainView()
        setupOuterView()
        setupImageView()
        setupNameLabel()
    }

    private func setupLayoutViews() {
        setupImageViewLayout()
        setupNameLabelLayout()
        setupDeleteButtonLayout()
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

    private func setupDeleteButton() {
        let btn = DeleteButton()
        deleteButton = btn
        deleteButton.setImage(UIImage(systemName: "minus"), for: .normal)
        deleteButton.tintColor = GlobalColors.backgroundColor
        deleteButton.backgroundColor = GlobalColors.redCancelColor
        deleteButton.addTarget(self, action: #selector(didUserDeleteButtonTapped(_:)), for: .touchUpInside)
        deleteButton.isHidden = true
        contentView.addSubview(deleteButton)
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

    private func setupDeleteButtonLayout() {
        btnSize = contentView.frame.height * 0.1
        guard let size = btnSize else { return }
        outerView.backgroundColor = .white
        deleteButton.pin
            .after(of: outerView, aligned: .top)
            .width(size)
            .height(size)
            .marginLeft(-(size / 3 + size / 2))
            .marginVertical(-6)

        deleteButton.layer.cornerRadius = deleteButton.frame.height / 2
    }

    private func checkDeleteButton() {
        if let output = output {
            if output.isEditButtonTapped() {
                guard let size = btnSize else { return }
                UIView.animate(withDuration: 0, animations: {
                    self.deleteButton.pin
                        .top(3%)
                        .right(7%)
                        .width(10)
                        .height(10)
                    self.deleteButton.alpha = 0
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.deleteButton.pin
                            .top(3%)
                            .right(3%)
                            .width(size)
                            .height(size)
                        self.deleteButton.alpha = 1
                    })
                })
                deleteButton.isHidden = false
            } else {
                UIView.animate(withDuration: 0, animations: {
                    self.deleteButton.pin
                        .top(3%)
                        .right(3%)
                        .width(20)
                        .height(20)
                    self.deleteButton.alpha = 1
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.deleteButton.pin
                            .top(3%)
                            .right(3%)
                            .width(0)
                            .height(0)
                        self.deleteButton.alpha = 0
                    }, completion: { (_) in
                        self.deleteButton.isHidden = true
                    })
                })
            }
        }
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

    // MARK: Actions
    @objc private func didUserDeleteButtonTapped(_ sender: Any) {
        guard let login = login else {
            return
        }
        output?.didDeleteUserTap(login: login)
    }
}

class DeleteButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -10, dy: -10).contains(point)
    }

      override init(frame: CGRect) {
          super.init(frame: frame)
      }

      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
}
