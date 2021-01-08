import UIKit
import PinLayout
import Kingfisher

final class EditWardrobeViewController: UIViewController {
    var output: EditWardrobeViewOutput?

    private weak var backgroundView: UIView!

    private weak var titleLabel: UILabel!

    private weak var goBackButton: UIButton!

    private weak var wardrobeNameTextField: UITextField!

    private weak var wardrobePhotoImageView: UIImageView!

    private weak var editWardrobeButton: UIButton!

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
        setupWardrobeNameTextField()
        setupWardrobePhotoImageView()
        setupEditWardrobeButton()
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
        titleLabel.text = "Редактировать гардероб"
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

    private func setupWardrobeNameTextField() {
        let textField = UITextField.customTextField(placeholder: "Название (обязательно)")

        wardrobeNameTextField = textField
        wardrobeNameTextField.delegate = self
        backgroundView.addSubview(wardrobeNameTextField)
    }

    private func setupWardrobePhotoImageView() {
        let imageView = UIImageView()

        wardrobePhotoImageView = imageView
        backgroundView.addSubview(wardrobePhotoImageView)

        wardrobePhotoImageView.backgroundColor = .white
        wardrobePhotoImageView.tintColor = .gray
        wardrobePhotoImageView.layer.cornerRadius = 15
        wardrobePhotoImageView.contentMode = .scaleToFill
        wardrobePhotoImageView.clipsToBounds = true

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapEditImageView))

        tapRecognizer.numberOfTapsRequired = 1
        wardrobePhotoImageView.addGestureRecognizer(tapRecognizer)
        wardrobePhotoImageView.isUserInteractionEnabled = true
    }

    private func setupEditWardrobeButton() {
        let button = UIButton()

        editWardrobeButton = button
        view.addSubview(editWardrobeButton)

        editWardrobeButton.backgroundColor = GlobalColors.mainBlueScreen
        editWardrobeButton.layer.cornerRadius = 20
        editWardrobeButton.dropShadow()

        editWardrobeButton.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 17)
        editWardrobeButton.setTitleColor(.white, for: .normal)
        editWardrobeButton.setTitle("Применить", for: .normal)

        editWardrobeButton.addTarget(self, action: #selector(didTapEditLookButton), for: .touchUpInside)
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
        layoutWardrobeNameTextField()
        layoutWardrobePhotoImageView()
        layoutEditWardrobeButton()
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

    private func layoutWardrobeNameTextField() {
        wardrobeNameTextField.pin
            .below(of: titleLabel).marginTop(6%)
            .hCenter()
            .width(90%)
            .height(8%)
    }

    private func layoutWardrobePhotoImageView() {
        wardrobePhotoImageView.pin
            .below(of: wardrobeNameTextField).marginTop(7%)
            .hCenter()
            .width(80%)
            .bottom(7%)
    }

    private func layoutEditWardrobeButton() {
        editWardrobeButton.pin
            .below(of: backgroundView).marginTop(4%)
            .hCenter()
            .width(90%)
            .height(6%)
    }

    @objc
    private func didTapEditLookButton() {
        output?.didTapEditWardrobeButton()
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

extension EditWardrobeViewController: EditWardrobeViewInput {
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

    func setWardrobeName(name: String) {
        wardrobeNameTextField.text = name
    }

    func setWardrobeImage(imageData: Data?) {
        guard let data = imageData else {
            wardrobePhotoImageView.image = UIImage(named: "addPhoto")
            return
        }

        wardrobePhotoImageView.image = UIImage(data: data)
    }

    func setWardrobeImage(url: URL?) {
        guard let url = url else {
            wardrobePhotoImageView.image = UIImage(named: "addPhoto")
            return
        }

        wardrobePhotoImageView.kf.setImage(with: url)
    }

    func getWardrobeImageData() -> Data? {
        return wardrobePhotoImageView.image?.jpegData(compressionQuality: 1)
    }

    func getWardrobeName() -> String? {
        return wardrobeNameTextField.text
    }

    func disableKeyboard() {
        view.endEditing(true)
    }
}

extension EditWardrobeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension EditWardrobeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension EditWardrobeViewController {
    private struct Constants {
        struct EditItemImageView {
            static let compression: CGFloat = 0.1
        }
    }
}
