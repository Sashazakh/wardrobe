import UIKit
import PinLayout

final class InviteViewController: UIViewController {

    private weak var headerView: UIView!
    private weak var backButton: UIButton!
    private weak var pageTitle: UILabel!
    private weak var loginTextField: UITextField!
    private weak var inviteButton: UIButton!
    private var tapOnMainViewGestureRecognizer: UITapGestureRecognizer!
    private var tapOnHeaderViewGestureRecognizer: UITapGestureRecognizer!

	var output: InviteViewOutput?

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
}

extension InviteViewController {
    private func setupUI() {
        setupBackground()
        setupHeaderView()
        setupPageTitle()
        setupBackButton()
        setupLoginTextField()
        setupInviteButton()
        setupRecognizers()
    }

    private func layoutUI() {
        layoutHeaderView()
        layoutPageTitle()
        layoutBackButton()
        layoutLoginTextField()
        layoutInviteButton()
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
        backButton.isUserInteractionEnabled = true
        headerView.addSubview(backButton)
    }

    private func layoutBackButton() {
        backButton.setImage(UIImage(systemName: "chevron.backward",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        backButton.tintColor = GlobalColors.backgroundColor
        backButton.contentVerticalAlignment = .fill
        backButton.contentHorizontalAlignment = .fill
        backButton.addTarget(self, action: #selector(didBackButtonTapped(_:)), for: .touchUpInside)

        backButton.pin
                    .height(25)
                    .width(20)
                    .before(of: pageTitle, aligned: .center)
                    .left(5%)
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
            .height(32%)
        headerView.roundLowerCorners(40)
        headerView.dropShadow()
    }

    // Title label

    private func setupPageTitle() {
        let label = UILabel()
        self.pageTitle = label
        pageTitle.numberOfLines = 2
        pageTitle.textAlignment = .center
        pageTitle.text = "Пригласить\nпользователя"
        pageTitle.font = UIFont(name: "DMSans-Bold", size: 25)
        pageTitle.adjustsFontSizeToFitWidth = true
        pageTitle.minimumScaleFactor = 0.1
        pageTitle.numberOfLines = 0
        pageTitle.sizeToFit()
        headerView.addSubview(pageTitle)
    }

    private func layoutPageTitle() {
        pageTitle.textColor = GlobalColors.backgroundColor
        pageTitle.pin
            .top(20%)
            .hCenter()
            .height(28%)
    }

    // loginTextField

    private func setupLoginTextField() {
        let textField = UITextField.customTextField(placeholder: "Имя пользователя")
        self.loginTextField = textField
        loginTextField.delegate = self
        headerView.addSubview(loginTextField)
    }

    private func layoutLoginTextField() {
        loginTextField.pin
            .left(10%)
            .right(10%)
            .below(of: pageTitle).marginTop(10%)
            .height(20%)
    }

    // invite Button

    private func setupInviteButton() {
        let button = UIButton()
        self.inviteButton = button
        inviteButton.setTitle("Отправить приглашение", for: .normal)
        inviteButton.backgroundColor = GlobalColors.mainBlueScreen
        inviteButton.setTitleColor(.gray, for: .highlighted)
        inviteButton.dropShadow()
        inviteButton.addTarget(self, action: #selector(didUserTapInviteButton(_:)),
                               for: .touchUpInside)
        self.view.addSubview(inviteButton)
    }

    private func layoutInviteButton() {
        inviteButton.pin
            .below(of: headerView).marginTop(5%)
            .left(5%)
            .right(5%)
            .height(7%)

        let width = inviteButton.frame.width
        inviteButton.layer.cornerRadius = width * 0.058
    }

    // MARK: Actions

    @objc private func didUserTapInviteButton(_ sender: Any) {
        guard let userLogin = loginTextField.text else { return }
        output?.didUserTapInviteButton(with: userLogin)
    }
}

extension InviteViewController {
    @objc func didBackButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension InviteViewController: InviteViewInput {
    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
}

extension InviteViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
