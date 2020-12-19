import UIKit
import PinLayout

final class MainScreenViewController: UIViewController {
    var output: MainScreenViewOutput?
    private weak var headerView: UIView!
    private weak var titleLabel: UILabel!
    private weak var settingsButton: UIButton!
    private weak var avatarImageView: UIImageView!
    private weak var outerImageView: UIView!
    private weak var nameLabel: UILabel!
    private weak var surnameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupHeaderViewLayout()
        setupTitleLabelLayout()
        setupSettingsButtonLayout()
        setupAvatarViewLayout()
        setupNameLabelLayout()
        setupSurnameLayout()
    }

    // MARK: setup views
    private func setupViews() {
        setupMainView()
        setupHeaderView()
        setupLabelView()
        setupSettingsButton()
        setupAvatarView()
        setupNameLabel()
        setupSurnameLabel()
    }

    private func setupMainView() {
        view.backgroundColor = GlobalColors.backgroundColor
    }

    private func setupHeaderView() {
        let view = UIView()
        headerView = view
        headerView.backgroundColor = GlobalColors.mainBlueScreen
        headerView.dropShadow()
        headerView.roundLowerCorners(40)
        self.view.addSubview(headerView)
    }

    private func setupSettingsButton() {
        let button = UIButton()
        settingsButton = button
        settingsButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        settingsButton.tintColor = GlobalColors.backgroundColor
        settingsButton.contentVerticalAlignment = .fill
        settingsButton.contentHorizontalAlignment = .fill
        self.headerView.addSubview(settingsButton)
    }

    private func setupLabelView() {
        let label = UILabel()
        titleLabel = label
        titleLabel.text = "Гардеробы"
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        titleLabel.textColor = GlobalColors.backgroundColor
        headerView.addSubview(titleLabel)
    }

    private func setupAvatarView() {
        setupOuterView()
        let imageView = UIImageView()
        avatarImageView = imageView
        avatarImageView.layer.borderWidth = 4
        avatarImageView.layer.borderColor = GlobalColors.backgroundColor.cgColor
        avatarImageView.image = UIImage(named: "morz")
        avatarImageView.dropShadow()
        avatarImageView.clipsToBounds = true
        outerImageView.addSubview(avatarImageView)
    }

    private func setupOuterView() {
        let view = UIView()
        outerImageView = view
        outerImageView.clipsToBounds = false
        outerImageView.dropShadow()
        self.view.addSubview(outerImageView)
    }

    private func setupNameLabel() {
        let label = UILabel()
        nameLabel = label
        nameLabel.text = "Морж"
        nameLabel.textColor = #colorLiteral(red: 0.03921568627, green: 0.1450980392, blue: 0.2431372549, alpha: 1)
        nameLabel.font = UIFont(name: "DMSans-Bold", size: 15)
        self.view.addSubview(nameLabel)
    }

    private func setupSurnameLabel() {
        let label = UILabel()
        surnameLabel = label
        surnameLabel.text = "Моржов"
        surnameLabel.textColor = #colorLiteral(red: 0.03921568627, green: 0.1450980392, blue: 0.2431372549, alpha: 1)
        surnameLabel.font = UIFont(name: "DMSans-Bold", size: 15)
        self.view.addSubview(surnameLabel)
    }

    // MARK: layout
    private func setupHeaderViewLayout() {
        headerView.pin
            .top()
            .right()
            .left()
            .height(23.275%)
    }

    private func setupTitleLabelLayout() {
        titleLabel.pin
            .hCenter()
            .top(38%)
            .height(33)
            .sizeToFit(.height)
    }

    private func setupSettingsButtonLayout() {
        settingsButton.pin
            .after(of: titleLabel, aligned: .center)
            .margin(19%)
            .width(titleLabel.frame.height * 0.7)
            .height(titleLabel.frame.height * 0.7)
    }

    private func setupAvatarViewLayout() {
        let imgRadius = UIScreen.main.bounds.height * 0.1477
        outerImageView.pin
            .below(of: headerView)
            .margin(-imgRadius / 2)
            .hCenter()
            .height(imgRadius)
            .width(imgRadius)
        avatarImageView.pin.all()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }

    private func setupNameLabelLayout() {
        nameLabel.pin
            .below(of: outerImageView, aligned: .center)
            .margin(1.3%)
            .height(3.4%)
            .sizeToFit(.height)
    }

    private func setupSurnameLayout() {
        surnameLabel.pin
            .below(of: nameLabel, aligned: .center)
            .margin(0.5%)
            .height(3.4%)
            .sizeToFit(.height)
    }
}

extension MainScreenViewController: MainScreenViewInput {
}
