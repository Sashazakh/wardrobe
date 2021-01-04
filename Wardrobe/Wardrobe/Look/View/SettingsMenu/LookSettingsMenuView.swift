import UIKit

enum EditLookMenuSections: Int, CaseIterable {
    case delete = 0, add

    var info: (String?, UIImage?) {
        switch self {
        case .delete:
            return ("Удалить вещи", UIImage(systemName: "minus.circle"))
        case .add:
            return ("Добавить вещи", UIImage(systemName: "plus.circle"))
        }
    }
}

class LookSettingsMenuView: UIView {
    private var dropTable: UITableView!

    var output: LookViewOutput?

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
        dropTable.layer.cornerRadius = UIScreen.main.bounds.height * 0.022
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

extension LookSettingsMenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        EditLookMenuSections.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropTableCell.identifier,
                                                       for: indexPath) as? DropTableCell
        else { return UITableViewCell() }

        guard let data = EditLookMenuSections(rawValue: indexPath.row) else {
            return cell
        }

        guard let icon = data.info.1, let label = data.info.0 else { return cell }

        cell.configureCell(icon: icon, label: label)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return frame.height / CGFloat(EditLookMenuSections.allCases.count)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch EditLookMenuSections(rawValue: indexPath.row) {
        case .delete:
            output?.didTapDeleteItems()
        case .add:
            output?.didTapAddItems()
        default:
            break
        }
    }
}

extension LookSettingsMenuView {
    struct Constants {
        static let cellHeight: CGFloat = 50
    }
}
