import UIKit
import PinLayout

final class NewItemScreenViewController: UIViewController {
    private weak var headerView: UIView!
    private weak var pageTitle: UILabel!
    private weak var backButton: UIButton!
    private weak var itemNameTextField: UITextField!
    private weak var imagePickButton: UIButton!
    private weak var addButton: UIButton!

	var output: NewItemScreenViewOutput?

	override func viewDidLoad() {
		super.viewDidLoad()
        setupUI()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
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
    }

    private func layoutUI() {
        layoutHeaderView()
        layoutPageTitle()
        layoutBackButton()
        layoutItemNameTextField()
        layoutImageButton()
        layoutAddButton()
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
        let textField = UITextField()

        itemNameTextField = textField
        headerView.addSubview(itemNameTextField)

        itemNameTextField.attributedPlaceholder = NSAttributedString(string: "Название",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        itemNameTextField.clipsToBounds = true
        itemNameTextField.layer.cornerRadius = 10
        itemNameTextField.layer.borderWidth = 1
        itemNameTextField.layer.borderColor = UIColor.white.cgColor
        itemNameTextField.backgroundColor = UIColor.white
        itemNameTextField.font = UIFont(name: "DMSans-Regular", size: 15)

        itemNameTextField.leftView = UIView(frame: CGRect(x: .zero,
                                                      y: .zero,
                                                      width: 10,
                                                      height: .zero))
        itemNameTextField.leftViewMode = .always
        itemNameTextField.rightView = UIView(frame: CGRect(x: .zero,
                                                       y: .zero,
                                                       width: 10,
                                                       height: .zero))
        itemNameTextField.rightViewMode = .unlessEditing

        itemNameTextField.clearButtonMode = .whileEditing
        itemNameTextField.autocorrectionType = .no
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
        imagePickButton.tintColor = .black
        imagePickButton.dropShadow()
        imagePickButton.layer.cornerRadius = 20

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

extension NewItemScreenViewController: NewItemScreenViewInput {
}
