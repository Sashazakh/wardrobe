import UIKit
import PinLayout

final class CreateWardrobeViewController: UIViewController, UINavigationControllerDelegate {
    private weak var headerView: UIView!
    private weak var pageTitle: UILabel!
    private weak var backButton: UIButton!
    private weak var wardrobeNameTextField: UITextField!
    private weak var wardrobeDescriptionTextView: UITextView!
    private weak var imageButton: UIButton!
    private weak var addButton: UIButton!
    private weak var imagePickButton: UIButton!
    private var tapOnMainViewGestureRecognizer: UITapGestureRecognizer!
    private var tapOnHeaderViewGestureRecognizer: UITapGestureRecognizer!
    private let pickerController: UIImagePickerController = UIImagePickerController()

    var output: CreateWardrobeViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func addImageAction(_ sender: Any) {
        chooseHowToPickImage()
    }
}

extension CreateWardrobeViewController {
    private func setupUI() {
        setupBackground()
        setupHeaderView()
        setupPageTitle()
        setupBackButton()
        setupWardrobeNameTextField()
        setupImageButton()
        setupAddButton()
        setupWardrobeDescription()
        setupImagePickButton()
        setupRecognizers()
        setupImagePicker()
    }

    private func layoutUI() {
        layoutHeaderView()
        layoutPageTitle()
        layoutBackButton()
        layoutWardrobeNameTextField()
        layoutWardrobeDescription()
        layoutImageButton()
        layoutAddButton()
        layoutImagePickButton()
    }

    private func setupImagePicker() {
        pickerController.delegate = self
        pickerController.allowsEditing = true
    }

    private func setupRecognizers() {
        tapOnMainViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.isUserInteractionEnabled = true
        tapOnMainViewGestureRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapOnMainViewGestureRecognizer)

        headerView.isUserInteractionEnabled = true
        tapOnHeaderViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tapOnHeaderViewGestureRecognizer.numberOfTouchesRequired = 1
        headerView.addGestureRecognizer(tapOnHeaderViewGestureRecognizer)
    }

    private func setupBackground() {
        self.view.backgroundColor = GlobalColors.backgroundColor
    }

    // Back Button

    private func setupBackButton() {
        let button = UIButton()
        self.backButton = button
        headerView.addSubview(backButton)
    }

    private func layoutBackButton() {
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = GlobalColors.backgroundColor
        backButton.contentVerticalAlignment = .fill
        backButton.contentHorizontalAlignment = .fill
        backButton.pin
            .height(pageTitle.frame.height * 0.85)
            .width(5%)
            .before(of: pageTitle, aligned: .center)
            .left(3%)
    }

    // Header View

    private func setupHeaderView() {
        let view = UIView()
        self.headerView = view
        self.view.addSubview(headerView)
    }

    private func layoutHeaderView() {
        headerView.backgroundColor = GlobalColors.mainBlueScreen
        headerView.pin
            .top()
            .left()
            .right()
            .height(61%)
        headerView.roundLowerCorners(40)
        headerView.dropShadow()
    }

    // Title label

    private func setupPageTitle() {
        let label = UILabel()
        self.pageTitle = label
        pageTitle.text = "Создать гардероб"
        pageTitle.font = UIFont(name: "DMSans-Bold", size: 25)
        headerView.addSubview(pageTitle)
    }

    private func layoutPageTitle() {
        pageTitle.textColor = GlobalColors.backgroundColor
        pageTitle.pin
            .top(11%)
            .hCenter()
            .sizeToFit()
    }

    // Item name text field

    private func setupWardrobeNameTextField() {
        let textField = UITextField.customTextField(placeholder: "Название гардероба")

        wardrobeNameTextField = textField
        wardrobeNameTextField.delegate = self
        headerView.addSubview(wardrobeNameTextField)
    }

    private func layoutWardrobeNameTextField() {
        wardrobeNameTextField.pin
            .below(of: pageTitle)
            .marginTop(8%)
            .left(10%)
            .right(10%)
            .height(8%)
    }

    // Wardrobe description

    private func setupWardrobeDescription() {
        let textVIew = UITextView()

        self.wardrobeDescriptionTextView = textVIew
        wardrobeDescriptionTextView.delegate = self
        wardrobeDescriptionTextView.layer.cornerRadius = 10
        wardrobeDescriptionTextView.layer.borderWidth = 1
        wardrobeDescriptionTextView.layer.borderColor = UIColor.white.cgColor
        wardrobeDescriptionTextView.backgroundColor = UIColor.white
        wardrobeDescriptionTextView.font = UIFont(name: "DMSans-Regular", size: 15)

        wardrobeDescriptionTextView.delegate = self

        wardrobeDescriptionTextView.text = "Описание"
        wardrobeDescriptionTextView.textColor = UIColor.gray
        wardrobeDescriptionTextView.autocorrectionType = .no

        wardrobeDescriptionTextView.textContainer.lineFragmentPadding = 10

        headerView.addSubview(wardrobeDescriptionTextView)
    }

    private func layoutWardrobeDescription() {
        wardrobeDescriptionTextView.pin
            .width(of: wardrobeNameTextField)
            .height(30%)
            .below(of: wardrobeNameTextField).marginTop(3%)
            .hCenter()
    }

    // image Button

    private func setupImageButton() {
        let button = UIButton()
        self.imageButton = button
        imageButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        imageButton.backgroundColor = GlobalColors.photoFillColor
        imageButton.contentVerticalAlignment = .fill
        imageButton.contentHorizontalAlignment = .fill
        imageButton.imageView?.contentMode = .scaleAspectFit
        imageButton.tintColor = GlobalColors.darkColor
        imageButton.isUserInteractionEnabled = false
        imageButton.dropShadow()

        headerView.addSubview(imageButton)
    }

    private func layoutImageButton() {

        let size = view.frame.height * 0.06
        imageButton.pin
            .below(of: wardrobeDescriptionTextView, aligned: .end)
            .marginTop(8%)
            .size(size)
            .left(10%)

        imageButton.layer.cornerRadius = size / 2

        let width = imageButton.frame.width * 0.2
        let height = imageButton.frame.height * 0.2
        imageButton.imageEdgeInsets = UIEdgeInsets(top: height, left: width, bottom: height, right: width)
    }

    // image pick button

    private func setupImagePickButton() {
        let button = UIButton()
        self.imagePickButton = button
        imagePickButton.setTitle("Выбрать фото", for: .normal)
        imagePickButton.titleLabel?.font = UIFont(name: "DMSans-Medium", size: 15)

        imagePickButton.backgroundColor = GlobalColors.backgroundColor
        imagePickButton.setTitleColor(.black, for: .normal)
        imagePickButton.setTitleColor(.gray, for: .highlighted)
        imagePickButton.isUserInteractionEnabled = true
        imagePickButton.addTarget(self, action: #selector(addImageAction(_:)), for: .touchUpInside)

        headerView.addSubview(imagePickButton)
    }

    private func layoutImagePickButton() {
        imagePickButton.pin
            .after(of: imageButton).marginLeft(10%)
            .right(10%)
            .height(of: imageButton)
            .below(of: wardrobeDescriptionTextView).marginTop(8%)

        let width = imagePickButton.frame.width

        imagePickButton.layer.cornerRadius = width * 0.090

    }

    // add Button

    private func setupAddButton() {
        let button = UIButton()
        self.addButton = button

        addButton.setTitle("Создать", for: .normal)
        addButton.backgroundColor = GlobalColors.mainBlueScreen
        addButton.dropShadow()
        addButton.setTitleColor(.gray, for: .highlighted)

        view.addSubview(addButton)
    }

    private func layoutAddButton() {
        addButton.pin
            .below(of: headerView).margin(10%)
            .width(80%)
            .height(7%)
            .hCenter()

        let width = addButton.frame.width

        addButton.layer.cornerRadius = width * 0.08
    }
}

extension CreateWardrobeViewController: CreateWardrobeViewInput {
}

extension CreateWardrobeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.gray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Описание"
            textView.textColor = UIColor.gray
        }
    }
}

extension CreateWardrobeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension CreateWardrobeViewController: UIImagePickerControllerDelegate {
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
               return UIAlertAction(title: title, style: .default) { [unowned self] _ in
                   pickerController.sourceType = type
                   present(self.pickerController, animated: true)
               }
           }

        private func chooseHowToPickImage() {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            if let action = self.action(for: .camera, title: "Camera") {
                       alertController.addAction(action)
            }
            if let action = self.action(for: .savedPhotosAlbum, title: "Photo library") {
                       alertController.addAction(action)
            }

            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }

        private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
            controller.dismiss(animated: true, completion: nil)
            guard let img = image else {
                return
            }
            output?.didImageLoaded(image: img)
            imageButton.imageEdgeInsets = UIEdgeInsets()// UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageButton.setImage(img, for: .normal)
            imageButton.contentMode = .scaleToFill
            imageButton.clipsToBounds = true
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            pickerController(picker, didSelect: nil)
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let image = info[.editedImage] as? UIImage else {
                pickerController(picker, didSelect: nil)
                return
            }
            pickerController(picker, didSelect: image)
        }
}
