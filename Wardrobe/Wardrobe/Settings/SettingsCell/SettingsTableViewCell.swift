import UIKit
import PinLayout

class SettingsTableViewCell: UITableViewCell {
    static let identifier = "cellForSettings"

    private weak var mainView: UIView!
    private weak var titleLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        setupCaontentView()
        setupMainView()
        setupTitleLabel()
    }

    private func setupLayout() {
        setupMainViewLayout()
        setupTitleLabelLayout()
    }

    // MARK: Setup views

    private func setupCaontentView() {
        contentView.backgroundColor = GlobalColors.backgroundColor
    }

    private func setupMainView() {
        let main = UIView()
        mainView = main
        mainView.backgroundColor = GlobalColors.mainBlueScreen
        mainView.dropShadow()
        contentView.addSubview(mainView)
    }

    private func setupTitleLabel() {
        let title = UILabel()
        titleLabel = title
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 20)
        titleLabel.textColor = GlobalColors.backgroundColor
        mainView.addSubview(titleLabel)
    }

    // MARK: Setup layouts

    private func setupMainViewLayout() {
        mainView.pin
            .top(13.28%)
            .left(7.9%)
            .right(7.9%)
            .bottom(14.28%)

        mainView.layer.cornerRadius = mainView.bounds.size.height * 0.353
    }

    private func setupTitleLabelLayout() {
        titleLabel.pin
            .center()
            .sizeToFit()
    }

    // MARK: Public functions

    func configureCell(label: String) {
        titleLabel.text = label
    }
}
