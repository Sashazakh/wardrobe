//
//  MyInvitesViewController.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 28.12.2020.
//  
//

import UIKit
import PinLayout

final class MyInvitesViewController: UIViewController {
	var output: MyInvitesViewOutput?

    private weak var headerView: UIView!
    private weak var titleLabel: UILabel!
    private weak var backButton: UIButton!
    private weak var inviteTableView: UITableView!
    private weak var noInvitesLabel: UILabel!

    private let screenBounds = UIScreen.main.bounds

    // MARK: VC lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

        setupViews()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        output?.didLoadView()
    }

    private func setupViews() {
        setupMainView()
        setupHeaderView()
        setupTitleLabel()
        setupBackButton()
        setupTableView()
        setupNoInvitesLabel()
    }

    private func setupLayout() {
        setupHeaderViewLayout()
        setupTitleLableLayout()
        setupBackButtonLayout()
        setupTitleLableLayout()
        setupTableViewLayout()
        setupNoInvitesLabelLayout()
    }

    // MARK: Setup views

    private func setupMainView() {
        view.backgroundColor = GlobalColors.backgroundColor
    }

    private func setupHeaderView() {
        let viewHeader = UIView()
        headerView = viewHeader
        headerView.backgroundColor = GlobalColors.mainBlueScreen
//        headerView.dropShadow()
//        headerView.roundLowerCorners(40)
        view.addSubview(headerView)
    }

    private func setupTitleLabel() {
        let title = UILabel()
        titleLabel = title
        titleLabel.text = Constants.titleLabel
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        titleLabel.textColor = GlobalColors.backgroundColor
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.1
        titleLabel.numberOfLines = 1
        titleLabel.sizeToFit()
        headerView.addSubview(titleLabel)
    }

    private func setupTableView() {
        let table = UITableView()
        inviteTableView = table
        inviteTableView.delegate = self
        inviteTableView.dataSource = self
        inviteTableView.backgroundColor = GlobalColors.backgroundColor
        inviteTableView.separatorStyle = .none
        inviteTableView.register(MyInvitesCell.self, forCellReuseIdentifier: MyInvitesCell.identifier)
        inviteTableView.tableFooterView = UIView(frame: .zero)
        view.addSubview(inviteTableView)
    }

    private func setupBackButton() {
        let btn = UIButton()
        backButton = btn
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = GlobalColors.backgroundColor
        backButton.contentVerticalAlignment = .fill
        backButton.contentHorizontalAlignment = .fill
        backButton.addTarget(self, action: #selector(didBackButtonTapped(_:)),
                             for: .touchUpInside)
        headerView.addSubview(backButton)
    }

    private func setupNoInvitesLabel() {
        let noInvite = UILabel()
        noInvitesLabel = noInvite
        noInvitesLabel.text = "У вас пока не приглашений."
        noInvitesLabel.textAlignment = .center
        noInvitesLabel.font = UIFont(name: "DMSans-Bold", size: 20)
        noInvitesLabel.textColor = GlobalColors.darkColor
        noInvitesLabel.adjustsFontSizeToFitWidth = true
        noInvitesLabel.minimumScaleFactor = 0.1
        noInvitesLabel.numberOfLines = 1
        noInvitesLabel.sizeToFit()
        noInvitesLabel.isHidden = true
        view.addSubview(noInvitesLabel)
    }

    // MARK: Setup layout

    private func setupHeaderViewLayout() {
        headerView.pin
            .top()
            .right()
            .left()
            .height(18%)
    }

    private func setupTitleLableLayout() {
        titleLabel.pin
            .hCenter()
            .top(38%)
            .height(50%)
    }

    private func setupBackButtonLayout() {
        backButton.pin
            .height(25)
            .width(20)

        backButton.pin
            .top(titleLabel.frame.midY - backButton.bounds.height / 2)
            .left(3%)
    }

    private func setupTableViewLayout() {
        inviteTableView.pin
            .below(of: headerView)
            .marginTop(5)
            .left()
            .right()
            .bottom()
    }

    private func setupNoInvitesLabelLayout() {
        noInvitesLabel.pin
            .center()
            .sizeToFit()
    }

    // MARK: Actions
    @objc func didBackButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MyInvitesViewController: MyInvitesViewInput {
    func showNoDataLabel() {
        noInvitesLabel.isHidden = false
    }

    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }

    func reloadData() {
        inviteTableView.reloadData()
    }

}

extension MyInvitesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.getNumberOfInvites() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyInvitesCell.identifier, for: indexPath) as? MyInvitesCell
        else {
            return UITableViewCell()
        }
        guard let inviteData = output?.getInvite(at: indexPath) else { return UITableViewCell() }
        cell.configureCell(with: inviteData)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenBounds.height * 0.156
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didInviteButtonTapped(at: indexPath)
    }
}
extension MyInvitesViewController {
    struct Constants {
        static let titleLabel: String = "Мои приглашения"
    }
}
