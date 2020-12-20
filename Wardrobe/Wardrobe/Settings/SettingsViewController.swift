import UIKit
import PinLayout
final class SettingsViewController: UIViewController {
	var output: SettingsViewOutput?

    private weak var headerView: UIView!
    private weak var titleLabel: UILabel!
    private weak var backButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()

        setupViews()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupLayout()
    }

    private func setupViews() {
        setupHeaderView()
        setupTitleLabel()
        setupBackButton()
    }

    private func setupLayout() {
        setupHeaderViewLayout()
        setupTitleLableLayout()
        setupBackButtonLayout()
    }

    // MARK: Setupping views

    private func setupHeaderView() {
        let viewHeader = UIView()
        headerView = viewHeader
        headerView.backgroundColor = GlobalColors.mainBlueScreen
        headerView.dropShadow()
        headerView.roundLowerCorners(40)
        view.addSubview(headerView)
    }

    private func setupTitleLabel() {
        let title = UILabel()
        titleLabel = title
        titleLabel.text = "Настройки"
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        titleLabel.textColor = GlobalColors.backgroundColor
        headerView.addSubview(titleLabel)
    }

    private func setupBackButton() {
        let btn = UIButton()
        backButton = btn
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = GlobalColors.backgroundColor
        backButton.contentVerticalAlignment = .fill
        backButton.contentHorizontalAlignment = .fill
        backButton.addTarget(self, action: #selector(didBackButtonTapped(_:)), for: .touchUpInside)
        headerView.addSubview(backButton)
    }
    // MARK: Setup layout

    private func setupHeaderViewLayout() {
        headerView.pin
            .top()
            .right()
            .left()
            .height(23.275%)
    }

    private func setupTitleLableLayout() {
        titleLabel.pin
            .hCenter()
            .top(38%)
            .sizeToFit()
    }

    private func setupBackButtonLayout() {
        backButton.pin
            .height(titleLabel.frame.height * 0.75)
            .width(5%)
            .before(of: titleLabel, aligned: .top)
            .left(3%)
    }

    // MARK: Button actions

    @objc func didBackButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SettingsViewController: SettingsViewInput {
}
