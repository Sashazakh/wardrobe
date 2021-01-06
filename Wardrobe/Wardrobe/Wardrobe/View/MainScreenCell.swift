import UIKit
import Kingfisher
import PinLayout

class MainScreenCell: WardrobeCell {

    private weak var deleteMarkButton: UIButton!

    weak var output: MainScreenViewOutput?

    private var wardrobeDataModel: WardrobeData?

    private var isneedWardrobeReload: Bool?

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
        checkDeleteButton()
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
        deleteMarkButton.backgroundColor = GlobalColors.redCancelColor
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
                UIView.animate(withDuration: 0, animations: {
                    self.deleteMarkButton.pin
                        .top(3%)
                        .right(7%)
                        .width(10)
                        .height(10)
                    self.deleteMarkButton.alpha = 0
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.deleteMarkButton.pin
                            .top(3%)
                            .right(3%)
                            .width(20)
                            .height(20)
                        self.deleteMarkButton.alpha = 1
                    })
                })
                deleteMarkButton.isHidden = false
            } else {
                UIView.animate(withDuration: 0, animations: {
                    self.deleteMarkButton.pin
                        .top(3%)
                        .right(3%)
                        .width(20)
                        .height(20)
                    self.deleteMarkButton.alpha = 1
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.deleteMarkButton.pin
                            .top(3%)
                            .right(3%)
                            .width(0)
                            .height(0)
                        self.deleteMarkButton.alpha = 0
                    }, completion: { (_) in
                        self.deleteMarkButton.isHidden = true
                    })
                })
            }
        }
    }

    // MARK: Public functions

    public func configureCell(wardobeData: WardrobeData,
                              output: MainScreenViewOutput?) {
        titleLable.text = wardobeData.name

        if let url = URL(string: wardobeData.imageUrl ?? "") {
            self.imageView.contentMode = .scaleToFill
            self.imageView.kf.setImage(with: url)
        } else {
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = GlobalConstants.deafultClothesImage
        }

        self.output = output
        self.wardrobeDataModel = wardobeData
        setNeedsLayout()
        layoutIfNeeded()
    }

    // MARK: User actions

    @objc private func didTapDeleteMarkButton(_ sender: Any) {
        guard let wardrobeData = wardrobeDataModel else { return }
        output?.didDeleteWardrobeTap(with: wardrobeData)
    }
}
