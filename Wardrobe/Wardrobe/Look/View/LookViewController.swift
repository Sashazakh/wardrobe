import UIKit
import PinLayout

final class LookViewController: UIViewController {
	var output: LookViewOutput?

    private weak var backgroundView: UIView!

    private weak var lookNameUp: UILabel!

    private weak var lookNameDown: UILabel!

    private weak var backToWardrobe: UIButton!

    private weak var editLookButton: UIButton!

    private weak var lookTableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()

        setupView()
        setupSubviews()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutBackgroundView()
        layoutLookNameUp()
        layoutLookNameDown()
        layoutBackToWardrobe()
        layoutEditLookButton()
        layoutLookTableView()
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupSubviews() {
        setupBackgroundView()
        setupLookNameUp()
        setupLookNameDown()
        setupBackToWardrobe()
        setupEditLookButton()
        setupLookTableView()
    }

    private func setupBackgroundView() {
        let background = UIView()

        backgroundView = background
        view.addSubview(backgroundView)

        backgroundView.backgroundColor = GlobalColors.mainBlueScreen
        backgroundView.dropShadow()
        backgroundView.roundLowerCorners(35)
    }

    private func setupLookNameUp() {
        let label = UILabel()

        lookNameUp = label
        backgroundView.addSubview(lookNameUp)

        lookNameUp.font = UIFont(name: "DMSans-Bold", size: 25)
        lookNameUp.textColor = .white
        lookNameUp.textAlignment = .center
        lookNameUp.text = "Набор"
    }

    private func setupLookNameDown() {
        let label = UILabel()

        lookNameDown = label
        backgroundView.addSubview(lookNameDown)

        lookNameDown.font = UIFont(name: "DMSans-Bold", size: 25)
        lookNameDown.textColor = .white
        lookNameDown.textAlignment = .center
        lookNameDown.text = "\"Корпоратив\""
    }

    private func setupBackToWardrobe() {
        let button = UIButton()

        backToWardrobe = button
        backgroundView.addSubview(backToWardrobe)

        backToWardrobe.setImage(UIImage(systemName: "chevron.backward",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        backToWardrobe.tintColor = GlobalColors.backgroundColor
        backToWardrobe.contentVerticalAlignment = .fill
        backToWardrobe.contentHorizontalAlignment = .fill
        backToWardrobe.addTarget(self, action: #selector(didTapBackToWardrobeButton), for: .touchUpInside)
    }

    private func setupEditLookButton() {
        let button = UIButton()

        editLookButton = button
        backgroundView.addSubview(editLookButton)

        editLookButton.setImage(UIImage(systemName: "square.and.pencil",
                                        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)),
                                        for: .normal)
        editLookButton.tintColor = GlobalColors.backgroundColor
        editLookButton.contentVerticalAlignment = .fill
        editLookButton.contentHorizontalAlignment = .fill
        editLookButton.addTarget(self, action: #selector(didTapEditLookButton), for: .touchUpInside)
    }

    private func setupLookTableView() {
        let tableView = UITableView()

        lookTableView = tableView
        view.addSubview(tableView)

        tableView.register(LookTableViewCell.self, forCellReuseIdentifier: "LookTableViewCell")

        tableView.delegate = self
        tableView.dataSource = self

        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
    }

    private func layoutBackgroundView() {
        backgroundView.pin
            .top(.zero)
            .width(100%)
            .height(Constants.screenHeight * 0.07 + 30 + 5 + 30 + 15)
    }

    private func layoutLookNameUp() {
        lookNameUp.pin
            .top(Constants.screenHeight * 0.07)
            .hCenter()
            .width(50%)
            .height(30)
    }

    private func layoutLookNameDown() {
        lookNameDown.pin
            .top(lookNameUp.frame.maxY + 5)
            .hCenter()
            .width(50%)
            .height(30)
    }

    private func layoutBackToWardrobe() {
        backToWardrobe.pin
            .height(25)
            .width(20)

        backToWardrobe.pin
            .top(backgroundView.bounds.height * 0.6 - backToWardrobe.bounds.height / 2)
            .left(5%)
    }

    private func layoutEditLookButton() {
        editLookButton.pin
            .height(25)
            .width(25)

        editLookButton.pin
            .top(backgroundView.bounds.height * 0.6 - editLookButton.bounds.height / 2)
            .right(5%)
    }

    private func layoutLookTableView() {
        lookTableView.pin
            .top(backgroundView.frame.maxY + 10)
            .hCenter()
            .width(100%)
            .bottom(10%)
    }

    @objc
    private func didTapBackToWardrobeButton() {

    }

    @objc
    private func didTapEditLookButton() {

    }
}

extension LookViewController: LookViewInput {
}

extension LookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 3
    }
}

extension LookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LookTableViewCell", for: indexPath) as? LookTableViewCell else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none
        cell.clipsToBounds = false
        cell.contentView.clipsToBounds = false

        return cell
    }
}

extension LookViewController {
    private struct Constants {
        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        static let screenWidth: CGFloat = UIScreen.main.bounds.width
    }
}
