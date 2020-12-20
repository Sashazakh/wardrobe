import UIKit
import PinLayout

final class LookTableViewCell: UITableViewCell {

    private weak var sectionNameLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutSectionNameLabel()
    }

    private func setupView() {
        setupSectionNameLabel()
    }

    private func setupSubviews() {
        setupSectionNameLabel()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    private func setupSectionNameLabel() {
        let label = UILabel()

        sectionNameLabel = label
        addSubview(sectionNameLabel)

        sectionNameLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        sectionNameLabel.textAlignment = .left
        sectionNameLabel.text = "Тапки"
    }

    private func layoutSectionNameLabel() {
        sectionNameLabel.pin
            .top(1%)
            .left(5%)
            .height(40)
            .width(50%)
    }
}
