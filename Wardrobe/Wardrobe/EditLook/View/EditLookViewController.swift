import UIKit
import PinLayout
import Kingfisher

final class EditLookViewController: UIViewController {
    var output: EditLookViewOutput?

    private weak var backgroundView: UIView!

    private weak var titleLabel: UILabel!

    private weak var goBackButton: UIButton!

    private weak var lookNameTextField: UITextField!

    private weak var lookPhotoImageView: UIImageView!

    private weak var editLookButton: UIButton!

    private var imagePickerController: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSubviews()

        output?.didLoadView()
    }

    private func setupView() {
        view.backgroundColor = .white

        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action: #selector(didTapView))

        tapRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapRecognizer)
    }

    private func setupSubviews() {
        setupBackgroundView()
        setupTitleLabel()
        setupGoBackButton()
        setupLookNameTextField()
        setupLookPhotoImageView()
        setupEditLookButton()
        setupImagePickerController()
    }

    private func setupBackgroundView() {
        let background = UIView()

        backgroundView = background
        view.addSubview(backgroundView)

        backgroundView.backgroundColor = GlobalColors.mainBlueScreen
        backgroundView.roundLowerCorners(35)
    }

    private func setupTitleLabel() {
        let label = UILabel()

        titleLabel = label
        backgroundView.addSubview(titleLabel)

        titleLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "Редактировать предмет"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.1
        titleLabel.numberOfLines = 0
    }

    private func setupGoBackButton() {
        let button = UIButton()

        goBackButton = button
        backgroundView.addSubview(goBackButton)

        goBackButton.setImage(UIImage(systemName: "chevron.backward",
                                      withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                      for: .normal)
        goBackButton.tintColor = GlobalColors.backgroundColor
        goBackButton.contentVerticalAlignment = .fill
        goBackButton.contentHorizontalAlignment = .fill
        goBackButton.addTarget(self, action: #selector(didTapGoBackButton), for: .touchUpInside)
    }

    private func setupLookNameTextField() {
        let textField = UITextField.customTextField(placeholder: "Название (обязательно)")

        lookNameTextField = textField
        lookNameTextField.delegate = self
        backgroundView.addSubview(lookNameTextField)
    }

    private func setupLookPhotoImageView() {
        let imageView = UIImageView()

        lookPhotoImageView = imageView
        backgroundView.addSubview(lookPhotoImageView)

        lookPhotoImageView.backgroundColor = .white
        lookPhotoImageView.tintColor = .gray
        lookPhotoImageView.layer.cornerRadius = 15
        lookPhotoImageView.contentMode = .scaleToFill
        lookPhotoImageView.clipsToBounds = true

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapEditImageView))

        tapRecognizer.numberOfTapsRequired = 1
        lookPhotoImageView.addGestureRecognizer(tapRecognizer)
        lookPhotoImageView.isUserInteractionEnabled = true
    }

    private func setupEditLookButton() {
        let button = UIButton()

        editLookButton = button
        view.addSubview(editLookButton)

        editLookButton.backgroundColor = GlobalColors.mainBlueScreen
        editLookButton.layer.cornerRadius = 20
        editLookButton.dropShadow()

        editLookButton.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 17)
        editLookButton.setTitleColor(.white, for: .normal)
        editLookButton.setTitle("Применить", for: .normal)

        editLookButton.addTarget(self, action: #selector(didTapEditLookButton), for: .touchUpInside)
    }

    private func setupImagePickerController() {
        imagePickerController = UIImagePickerController()

        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutBackgroundView()
        layoutTitleLabel()
        layoutGoBackButton()
        layoutLookNameTextField()
        layoutLookPhotoImageView()
        layoutEditLookButton()
    }

    private func layoutBackgroundView() {
        backgroundView.pin
            .top(.zero)
            .width(100%)
            .height(65%)
    }

    private func layoutTitleLabel() {
        titleLabel.pin
            .top(10%)
            .hCenter()
            .width(50%)
            .height(5%)
    }

    private func layoutGoBackButton() {
        goBackButton.pin
            .height(25)
            .width(20)

        goBackButton.pin
            .top(titleLabel.frame.midY - goBackButton.bounds.height / 2)
            .left(5%)
    }

    private func layoutLookNameTextField() {
        lookNameTextField.pin
            .below(of: titleLabel).marginTop(6%)
            .hCenter()
            .width(90%)
            .height(8%)
    }

    private func layoutLookPhotoImageView() {
        lookPhotoImageView.pin
            .below(of: lookNameTextField).marginTop(7%)
            .hCenter()
            .width(80%)
            .bottom(7%)
    }

    private func layoutEditLookButton() {
        editLookButton.pin
            .below(of: backgroundView).marginTop(4%)
            .hCenter()
            .width(90%)
            .height(6%)
    }

    @objc
    private func didTapEditLookButton() {
        output?.didTapEditLookButton()
    }

    @objc
    private func didTapGoBackButton() {
        output?.didTapGoBackButton()
    }

    @objc
    private func didTapEditImageView() {
        output?.didTapEditImageView()
    }

    @objc
    private func didTapView() {
        output?.didTapView()
    }
}

extension EditLookViewController: EditLookViewInput {
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

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)

        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }

    func setLookName(name: String) {
        lookNameTextField.text = name
    }

    func setLookImage(imageData: Data?) {
        guard let data = imageData else {
            lookPhotoImageView.image = UIImage(named: "addPhoto")
            return
        }

        lookPhotoImageView.image = UIImage(data: data)
    }

    func setLookImage(url: URL?) {
        guard let url = url else {
            lookPhotoImageView.image = UIImage(named: "addPhoto")
            return
        }

        lookPhotoImageView.kf.setImage(with: url)
    }

    func getLookImageData() -> Data? {
        return lookPhotoImageView.image?.jpegData(compressionQuality: 1)
    }

    func getLookName() -> String? {
        return lookNameTextField.text
    }

    func disableKeyboard() {
        view.endEditing(true)
    }
}

extension EditLookViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension EditLookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

        output?.userDidSetImage(imageData: image.jpegData(compressionQuality: Constants.EditItemImageView.compression))
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

extension EditLookViewController {
    private struct Constants {
        struct EditItemImageView {
            static let compression: CGFloat = 0.1
        }
    }
}
