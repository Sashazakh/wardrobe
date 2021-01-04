import UIKit

enum AllClothesDropDownMenuSections: Int, CaseIterable {
    case  newCategory = 0, edit

    var info: (String?, UIImage?) {
        switch self {
        case .newCategory:
            return ("Создать категорию", UIImage(systemName: "plus.circle"))
        case .edit:
            return ("Редактировать", UIImage(systemName: "square.and.pencil"))
        }
    }
}

class AllClothesDropDownView: UIView {
    private var dropTable: UITableView!

    var output: AllClothesViewOutput?

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
        setupMainView()
        setupDropTable()
    }

    private func setupLayout() {
        setupDropTableLayout()
    }

    // MARK: Setup views

    private func setupMainView() {
        isUserInteractionEnabled = true
    }

    private func setupDropTable() {
        let tbl = UITableView()
        dropTable = tbl
        dropTable.layer.cornerRadius = UIScreen.main.bounds.height * 0.022
        dropTable.delegate = self
        dropTable.dataSource = self
        dropTable.separatorStyle = .none
        dropTable.isScrollEnabled = false
        dropTable.register(DropTableCell.self, forCellReuseIdentifier: DropTableCell.identifier)
        dropTable.backgroundColor = GlobalColors.backgroundColor
        self.addSubview(tbl)
    }

    // MARK: Layout

    private func setupDropTableLayout() {
        dropTable.pin
            .all()
    }
}

extension AllClothesDropDownView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AllClothesDropDownMenuSections.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropTableCell.identifier,
                                                       for: indexPath) as? DropTableCell
        else { return UITableViewCell() }

        guard let data = AllClothesDropDownMenuSections(rawValue: indexPath.row) else {
            return cell
        }

        guard let icon = data.info.1, let label = data.info.0 else { return cell }

        cell.configureCell(icon: icon, label: label)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return frame.height / CGFloat(DropDownMenuSections.allCases.count)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch AllClothesDropDownMenuSections(rawValue: indexPath.row) {
        case .newCategory:
            output?.didTapNewCategoryButton()
        case .edit:
            output?.didTapEditButton()
        default:
            break
        }
    }
}
