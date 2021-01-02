//
//  DropDownView.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 01.01.2021.
//

import UIKit

enum DropDownMenuSections: Int, CaseIterable {
    case  persons = 0, edit

    var info: (String?, UIImage?) {
        switch self {
        case .persons:
            return ("Пользователи", UIImage(systemName: "person.3.fill"))
        case .edit:
            return ("Редактировать", UIImage(systemName: "square.and.pencil"))
        }
    }
}

class DropDownView: UIView {
    private var dropTable: UITableView!

    var output: WardrobeDetailViewOutput?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setupDropTableLayout()
    }

    private func setupViews() {
        isUserInteractionEnabled = true
        setupDropTable()
    }

    private func setupLayout() {
        setupDropTableLayout()
    }

    // MARK: Setup views

    private func setupDropTable() {
        let tbl = UITableView()
        dropTable = tbl
        dropTable.layer.cornerRadius = 20
        dropTable.delegate = self
        dropTable.dataSource = self
        dropTable.separatorStyle = .none
        dropTable.isScrollEnabled = false
        dropTable.register(DropTableCell.self, forCellReuseIdentifier: DropTableCell.identifier)
        self.addSubview(tbl)
    }

    // MARK: Layout

    private func setupDropTableLayout() {
        dropTable.pin
            .all()
    }
}

extension DropDownView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DropDownMenuSections.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropTableCell.identifier,
                                                       for: indexPath) as? DropTableCell
        else { return UITableViewCell() }

        guard let data = DropDownMenuSections(rawValue: indexPath.row) else {
            return cell
        }

        guard let icon = data.info.1, let label = data.info.0 else { return cell }

        cell.configureCell(icon: icon, label: label)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch DropDownMenuSections(rawValue: indexPath.row) {
        case .persons:
            output?.didPersonTap()
        case .edit:
            output?.didEditButtonTap()
        default:
            break
        }
    }
}

extension DropDownView {
    struct Constants {
        static let cellHeight: CGFloat = 50
    }
}
