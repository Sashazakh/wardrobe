import UIKit
import PinLayout

final class SetupLookViewController: UIViewController {
	var output: SetupLookViewOutput?

    private weak var backgroundView: UIView!

    private weak var titleLabel: UILabel!

    private weak var backToCreateWardrobeButton: UIButton!

    private weak var lookNameTextField: UITextField!

    private weak var addLookPhotoButton: UIButton!

    private weak var lookPhotoImageView: UIImageView!

    private weak var setupLookButton: UIButton!

    private var imagePickerController: UIImagePickerController!

    private var photoDidChanged: Bool = false

	override func viewDidLoad() {
		super.viewDidLoad()

        setupView()
        setupSubviews()
	}

    private func setupView() {
        view.backgroundColor = .white

        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action: #selector(didTapView))

        tapRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapRecognizer)
    }

    private func setupSubviews() {
        setupBackroundView()
        setupTitleLabel()
        setupBackToCreateWardrobeButton()
        setupLookNameTextField()
        setupAddLookPhotoButton()
        setupLookPhotoImageView()
        setupSetupLookButton()
        setupImagePicker()
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

    private func setupLookNameTextField() {
        let textField = UITextField.customTextField(placeholder: "Название (обязательно)")

        lookNameTextField = textField
        backgroundView.addSubview(lookNameTextField)
    }

    private func setupAddLookPhotoButton() {
        let button = UIButton()

        addLookPhotoButton = button
        backgroundView.addSubview(addLookPhotoButton)

        addLookPhotoButton.backgroundColor = .white
        addLookPhotoButton.layer.cornerRadius = 20

        addLookPhotoButton.titleLabel?.font = UIFont(name: "DMSans-Medium", size: 15)
        addLookPhotoButton.setTitleColor(GlobalColors.darkColor, for: .normal)
        addLookPhotoButton.setTitle("Выбрать фото", for: .normal)

        addLookPhotoButton.addTarget(self, action: #selector(didTapAddLookPhotoButton), for: .touchUpInside)
    }

    private func setupLookPhotoImageView() {
        let imageView = UIImageView()

        lookPhotoImageView = imageView
        backgroundView.addSubview(lookPhotoImageView)

        lookPhotoImageView.backgroundColor = .white
        lookPhotoImageView.image = UIImage(systemName: "camera.fill")
        lookPhotoImageView.contentMode = .center
        lookPhotoImageView.clipsToBounds = true
        lookPhotoImageView.tintColor = .gray
    }

    private func setupSetupLookButton() {
        let button = UIButton()

        setupLookButton = button
        view.addSubview(setupLookButton)

        setupLookButton.backgroundColor = GlobalColors.mainBlueScreen
        setupLookButton.layer.cornerRadius = 20
        setupLookButton.dropShadow()

        setupLookButton.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 17)
        setupLookButton.setTitleColor(.white, for: .normal)
        setupLookButton.setTitle("Создать", for: .normal)

        setupLookButton.addTarget(self, action: #selector(didTapSetupLookButton), for: .touchUpInside)
    }

    private func setupImagePicker() {
        imagePickerController = UIImagePickerController()

        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        layoutBackroundView()
        layoutTitleLabel()
        layoutBackToCreateWardrobeButton()
        layoutLookNameTextField()
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

    private func layoutLookNameTextField() {
        lookNameTextField.pin
            .below(of: titleLabel).marginTop(10%)
            .hCenter()
            .width(90%)
            .height(18%)
    }

    private func layoutAddLookPhotoButton() {
        addLookPhotoButton.pin
            .below(of: lookNameTextField).marginTop(11%)
            .width(65%)
            .right(5%)
            .height(14%)
    }

    private func layoutLookPhotoImageView() {
        lookPhotoImageView.pin
            .height(20%)

        lookPhotoImageView.pin
            .width(lookPhotoImageView.bounds.height)

        lookPhotoImageView.layer.cornerRadius = lookPhotoImageView.bounds.height / 2

        lookPhotoImageView.pin
            .top(addLookPhotoButton.frame.midY - lookPhotoImageView.bounds.height / 2)
            .left(5%)
    }

    private func layoutSetupLookButton() {
        setupLookButton.pin
            .below(of: backgroundView).marginTop(5%)
            .hCenter()
            .width(90%)
            .height(6%)
    }

    @objc
    private func didTapBackToCreateWardrobeButton() {
        output?.didTapBackToCreateWardrobeButton()
    }

    @objc
    private func didTapAddLookPhotoButton() {
        output?.didTapAddLookPhotoButton()
    }

    @objc
    private func didTapSetupLookButton() {
        output?.didTapSetupLookButton()
    }

    @objc
    private func didTapView() {
        output?.didTapView()
    }
}

extension SetupLookViewController: SetupLookViewInput {
    func disableKeyboard() {
        view.endEditing(true)
    }

    func disableSetupButtonInteraction() {
        setupLookButton.isUserInteractionEnabled = false
    }

    func enableSetupButtonInteraction() {
        setupLookButton.isUserInteractionEnabled = true
    }

    func setLookImage(imageData: Data) {
        lookPhotoImageView.contentMode = .scaleToFill
        lookPhotoImageView.image = UIImage(data: imageData)
    }

    func showPickPhotoAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = alertAction(type: .camera, title: "Камера") {
            alertController.addAction(action)
        }

        if let action = alertAction(type: .savedPhotosAlbum, title: "Галерея") {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alertController.modalPresentationStyle = .automatic
        present(alertController, animated: true, completion: nil)
    }

    func getLookName() -> String? {
        return lookNameTextField.text
    }

    func getLookImage() -> Data? {
        return photoDidChanged ? lookPhotoImageView.image?.jpegData(compressionQuality: 1) : nil
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)

        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
}

extension SetupLookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func alertAction(type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            imagePickerController.sourceType = type
            present(self.imagePickerController, animated: true)
        }
    }

    private func imagePickerController(_ controller: UIImagePickerController, selectedImage: UIImage?) {
        controller.dismiss(animated: true, completion: nil)

        guard let image = selectedImage else {
            return
        }

        photoDidChanged = true
        output?.userDidSetImage(imageData: image.jpegData(compressionQuality: Constants.LookPhotoImageView.compression))
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            imagePickerController(picker, selectedImage: nil)
            return
        }

        imagePickerController(picker, selectedImage: image)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController(picker, selectedImage: nil)
    }
}

extension SetupLookViewController {
    private struct Constants {
        struct LookPhotoImageView {
            static let compression: CGFloat = 0.1
        }
    }
}
