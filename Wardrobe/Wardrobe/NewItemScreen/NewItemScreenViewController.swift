import UIKit
import PinLayout

final class NewItemScreenViewController: UIViewController, UINavigationControllerDelegate {
    private weak var headerView: UIView!
    private weak var pageTitle: UILabel!
    private weak var backButton: UIButton!
    private weak var itemNameTextField: UITextField!
    private weak var imagePickButton: UIButton!
    private weak var addButton: UIButton!
    private let pickerController: UIImagePickerController = UIImagePickerController()
    private var tapOnMainViewGestureRecognizer: UITapGestureRecognizer!
    private var tapOnHeaderViewGestureRecognizer: UITapGestureRecognizer!

	var output: NewItemScreenViewOutput?

	override func viewDidLoad() {
		super.viewDidLoad()
        setupUI()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }

    @objc private func addImageAction(_ sender: Any) {
        chooseHowToPickImage()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension NewItemScreenViewController {
    private func setupUI() {
        setupBackground()
        setupHeaderView()
        setupPageTitle()
        setupBackButton()
        setupItemNameTextField()
        setupImageButton()
        setupAddButton()
        setupImagePicker()
        setupRecognizers()
    }

    private func layoutUI() {
        layoutHeaderView()
        layoutPageTitle()
        layoutBackButton()
        layoutItemNameTextField()
        layoutImageButton()
        layoutAddButton()
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

    private func setupImagePicker() {
        pickerController.delegate = self
        pickerController.allowsEditing = true
    }

    private func setupBackground() {
        self.view.backgroundColor = GlobalColors.backgroundColor
        self.view.isUserInteractionEnabled = true
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
            .height(70%)
        headerView.roundLowerCorners(40)
        headerView.dropShadow()
    }

    // Title label

    private func setupPageTitle() {
        let label = UILabel()
        self.pageTitle = label
        pageTitle.text = "Добавить предмет"
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

    private func setupItemNameTextField() {
        let textField = UITextField.customTextField(placeholder: "Название")

        itemNameTextField = textField
        itemNameTextField.delegate = self
        headerView.addSubview(itemNameTextField)
    }

    private func layoutItemNameTextField() {
        itemNameTextField.pin
            .below(of: pageTitle).margin(8%)
            .hCenter()
            .width(80%)
            .height(8%)
    }

    // image Button

    private func setupImageButton() {
        let button = UIButton()
        self.imagePickButton = button
        imagePickButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        imagePickButton.backgroundColor = GlobalColors.photoFillColor
        imagePickButton.contentVerticalAlignment = .fill
        imagePickButton.contentHorizontalAlignment = .fill
        imagePickButton.imageView?.contentMode = .scaleAspectFit
        imagePickButton.tintColor = .black//GlobalColors.darkColor
        imagePickButton.layer.cornerRadius = 20
        imagePickButton.addTarget(self, action: #selector(addImageAction(_:)), for: .touchUpInside)

        headerView.addSubview(imagePickButton)
    }

    private func layoutImageButton() {
        imagePickButton.pin
            .width(70%)
            .below(of: itemNameTextField).margin(8%)
            .height(45%)
            .hCenter()

        let width = imagePickButton.frame.width * 0.35
        let height = imagePickButton.frame.height * 0.35
        imagePickButton.imageEdgeInsets = UIEdgeInsets(top: height, left: width, bottom: height, right: width)
    }

    // add Button

    private func setupAddButton() {
        let button = UIButton()
        self.addButton = button

        addButton.setTitle("Добавить", for: .normal)
        addButton.backgroundColor = GlobalColors.mainBlueScreen
        addButton.dropShadow()

        view.addSubview(addButton)
    }

    private func layoutAddButton() {
        addButton.pin
            .below(of: headerView).margin(10%)
            .width(80%)
            .height(7%)
            .hCenter()

        let width = addButton.frame.width

        addButton.layer.cornerRadius = width * 0.078
    }
}

extension NewItemScreenViewController: UIImagePickerControllerDelegate {
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
            let toset = img.alpha(0.5)
            imagePickButton.setBackgroundImage(toset, for: .normal)
            imagePickButton.clipsToBounds = true
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

extension NewItemScreenViewController: NewItemScreenViewInput {

}

extension NewItemScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
