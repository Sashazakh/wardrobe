import UIKit
import Kingfisher
import PinLayout

class MainScreenCell: WardrobeCell {

    private weak var deleteMarkButton: UIButton!

    weak var output: MainScreenViewOutput?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutDeleteButtonLayout()
    }

    func setupViews() {
        setupDeleteButton()
    }

    // MARK: Setup

    func setupDeleteButton() {
        let button = UIButton()

        deleteMarkButton = button
        imageView.addSubview(deleteMarkButton)

        deleteMarkButton.setImage(UIImage(systemName: "minus",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        deleteMarkButton.tintColor = GlobalColors.backgroundColor
        deleteMarkButton.addTarget(self, action: #selector(didTapDeleteMarkButton), for: .touchUpInside)
        deleteMarkButton.backgroundColor = UIColor(red: 240 / 255,
                                                   green: 98 / 255,
                                                   blue: 98 / 255,
                                                   alpha: 1)
        deleteMarkButton.layer.cornerRadius = 10
    }

    // MARK: Setup layout

    private func layoutDeleteButtonLayout() {
        deleteMarkButton.pin
            .top(3%)
            .right(3%)
            .width(20)
            .height(20)
    }

    private func checkDeleteButton() {
        if let output = output {
            if output.isEditButtonTapped() {
                deleteMarkButton.isHidden = false
            } else {
                deleteMarkButton.isHidden = true
            }
        }
    }

    // MARK: Public functions

    public func configureCell(wardobeData: WardrobeData, output: MainScreenViewOutput?) {
        titleLable.text = wardobeData.name

        let url = URL(string: wardobeData.imageUrl ?? "")
        self.imageView.kf.setImage(with: url)

        self.output = output
        checkDeleteButton()
    }

    // MARK: User actions

    @objc private func didTapDeleteMarkButton(_ sender: Any) {
        print("Hello")
    }
}
