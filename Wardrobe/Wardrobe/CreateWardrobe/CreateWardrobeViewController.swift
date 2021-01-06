import UIKit
import PinLayout

final class CreateWardrobeViewController: UIViewController, UINavigationControllerDelegate {
    private weak var headerView: UIView!
    private weak var pageTitle: UILabel!
    private weak var backButton: UIButton!
    private weak var wardrobeNameTextField: UITextField!
    private weak var imageButton: UIButton!
    private weak var imageView: UIImageView!
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
        setupImageView()
        setupAddButton()
        setupImagePickButton()
        setupRecognizers()
        setupImagePicker()
        setupImageButton()
    }

    private func layoutUI() {
        layoutHeaderView()
        layoutPageTitle()
        layoutBackButton()
        layoutWardrobeNameTextField()
        layoutImagePickButton()
        layoutImageView()
        layoutAddButton()
        layoutImageButton()
    }

    private func setupImagePicker() {
        pickerController.delegate = self
        pickerController.allowsEditing = false
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
        backButton.setImage(UIImage(systemName: "chevron.backward",
                                      withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                      for: .normal)
        backButton.tintColor = GlobalColors.backgroundColor
        backButton.contentVerticalAlignment = .fill
        backButton.contentHorizontalAlignment = .fill
        backButton.addTarget(self, action: #selector(didBackButtonTap(_:)),
                             for: .touchUpInside)
        backButton.pin
            .height(25)
            .width(20)
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
            .height(30%)
        headerView.roundLowerCorners(35)
        headerView.dropShadow()
    }

    // Title label

    private func setupPageTitle() {
        let label = UILabel()
        self.pageTitle = label
        pageTitle.text = "Создать гардероб"
        pageTitle.font = UIFont(name: "DMSans-Bold", size: 25)
        pageTitle.adjustsFontSizeToFitWidth = true
        pageTitle.minimumScaleFactor = 0.1
        headerView.addSubview(pageTitle)
    }

    private func layoutPageTitle() {
        pageTitle.textColor = GlobalColors.backgroundColor
        pageTitle.pin
            .top(20%)
            .hCenter()
            .width(50%)
            .height(10%)
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
            .marginTop(10%)
            .hCenter()
            .width(90%)
            .height(17%)
    }

    // image Button

    private func setupImageButton() {
        let button = UIButton()
        self.imageButton = button
        imageButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        imageButton.isUserInteractionEnabled = false
        imageButton.tintColor = .gray
        imageView.addSubview(imageButton)
    }

    private func layoutImageButton() {
        imageButton.pin
            .height(50%)
            .width(50%)
            .center()

    }

    // image View

    private func setupImageView() {
        let view = UIImageView()
        self.imageView = view
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        imageView.tintColor = GlobalColors.darkColor
        imageView.isUserInteractionEnabled = false
        imageView.dropShadow()
        headerView.addSubview(imageView)
    }

    private func layoutImageView() {

        let size = view.frame.height * 0.06
        imageView.pin
            .below(of: wardrobeNameTextField, aligned: .start)
            .size(size)

        imageView.pin
            .top(imagePickButton.frame.midY - imageView.bounds.height / 2)

        imageView.layer.cornerRadius = size / 2

//        let width = imageView.frame.width * 0.2
//        let height = imageView.frame.height * 0.2
        // imageView.imageEdgeInsets = UIEdgeInsets(top: height, left: width, bottom: height, right: width)
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
            .width(65%)
            .right(5%)
            .height(15%)
            .below(of: wardrobeNameTextField).marginTop(13%)

        let height = imagePickButton.frame.height

        imagePickButton.layer.cornerRadius = height / 2

    }

    // add Button

    private func setupAddButton() {
        let button = UIButton()
        self.addButton = button

        addButton.setTitle("Создать", for: .normal)
        addButton.backgroundColor = GlobalColors.mainBlueScreen
        addButton.dropShadow()
        addButton.setTitleColor(.gray, for: .highlighted)
        addButton.addTarget(self, action: #selector(didAddButtonTap(_:)), for: .touchUpInside)

        view.addSubview(addButton)
    }

    private func layoutAddButton() {
        addButton.pin
            .below(of: headerView).marginTop(5%)
            .width(90%)
            .height(6%)
            .hCenter()

        addButton.layer.cornerRadius = 20
    }

    // MARK: : User actions

    @objc private func didAddButtonTap(_ sender: Any) {
        guard let wardrobeName = wardrobeNameTextField.text,
              !wardrobeName.isEmpty else {
            showALert(title: "Ошибка", message: "Введите название гардероба")
            return
        }

        output?.addWardrobe(name: wardrobeName)
    }

    @objc private func didBackButtonTap(_ sender: Any) {
        popView()
    }
}

extension CreateWardrobeViewController: CreateWardrobeViewInput {
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }

    func showALert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)

        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }

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
            if let action = self.action(for: .camera, title: "Камера") {
                       alertController.addAction(action)
            }
            if let action = self.action(for: .savedPhotosAlbum, title: "Галерея") {
                       alertController.addAction(action)
            }

            alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }

        private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
            controller.dismiss(animated: true, completion: nil)
            guard let img = image else {
                return
            }
            if let imgData = img.jpegData(compressionQuality: 0.1) {
                output?.didImageLoaded(image: imgData)
                // imageView.imageEdgeInsets = UIEdgeInsets()// UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                // imageView.setImage(img, for: .normal)
                imageButton.isHidden = true
                imageView.image = img
                imageView.contentMode = .scaleToFill
                imageView.clipsToBounds = true
            }

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            pickerController(picker, didSelect: nil)
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let image = info[.originalImage] as? UIImage else {
                pickerController(picker, didSelect: nil)
                return
            }
            pickerController(picker, didSelect: image)
        }
}

extension UIImagePickerController {
    open override var childForStatusBarHidden: UIViewController? {
        return nil
    }

    open override var prefersStatusBarHidden: Bool {
        return true
    }
}
