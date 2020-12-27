import UIKit
import PinLayout

final class SetupLookViewController: UIViewController {
	var output: SetupLookViewOutput?

    private weak var backgroundView: UIView!

    private weak var titleLabel: UILabel!

    private weak var backToCreateWardrobeButton: UIButton!

    private weak var addLookPhotoButton: UIButton!

    private weak var lookPhotoImageView: UIImageView!

    private weak var setupLookButton: UIButton!

    private var imagePickerController: UIImagePickerController!

	override func viewDidLoad() {
		super.viewDidLoad()

        setupView()
        setupSubviews()
	}

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupSubviews() {
        setupBackroundView()
        setupTitleLabel()
        setupBackToCreateWardrobeButton()
        setupAddLookPhotoButton()
        setupLookPhotoImageView()
        setupSetupLookButton()
    }

    private func setupBackroundView() {
        let subview = UIView()

        backgroundView = subview
        view.addSubview(backgroundView)

        backgroundView.backgroundColor = GlobalColors.mainBlueScreen
        backgroundView.dropShadow()
        backgroundView.roundLowerCorners(35)
    }

    private func setupTitleLabel() {
        let label = UILabel()

        titleLabel = label
        backgroundView.addSubview(titleLabel)

        titleLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "Создать набор"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.1
        titleLabel.numberOfLines = 0
    }

    private func setupBackToCreateWardrobeButton() {
        let button = UIButton()

        backToCreateWardrobeButton = button
        backgroundView.addSubview(backToCreateWardrobeButton)

        backToCreateWardrobeButton.setImage(UIImage(systemName: "chevron.backward",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        backToCreateWardrobeButton.tintColor = GlobalColors.backgroundColor
        backToCreateWardrobeButton.contentVerticalAlignment = .fill
        backToCreateWardrobeButton.contentHorizontalAlignment = .fill
        backToCreateWardrobeButton.addTarget(self, action: #selector(didTapBackToCreateWardrobeButton), for: .touchUpInside)
    }

    private func setupAddLookPhotoButton() {

    }

    private func setupLookPhotoImageView() {

    }

    private func setupSetupLookButton() {

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        layoutBackroundView()
        layoutTitleLabel()
        layoutBackToCreateWardrobeButton()
        layoutAddLookPhotoButton()
        layoutLookPhotoImageView()
        layoutSetupLookButton()
    }

    private func layoutBackroundView() {
        backgroundView.pin
            .top(.zero)
            .width(100%)
            .height(30%)
    }

    private func layoutTitleLabel() {
        titleLabel.pin
            .top(25%)
            .hCenter()
            .width(50%)
            .height(10%)
    }

    private func layoutBackToCreateWardrobeButton() {
        backToCreateWardrobeButton.pin
            .height(25)
            .width(20)

        backToCreateWardrobeButton.pin
            .top(titleLabel.frame.midY - backToCreateWardrobeButton.bounds.height / 2)
            .left(5%)
    }

    private func layoutAddLookPhotoButton() {

    }

    private func layoutLookPhotoImageView() {

    }

    private func layoutSetupLookButton() {

    }

    @objc
    private func didTapBackToCreateWardrobeButton() {
        output?.didTapBackToCreateWardrobeButton()
    }
}

extension SetupLookViewController: SetupLookViewInput {
}
