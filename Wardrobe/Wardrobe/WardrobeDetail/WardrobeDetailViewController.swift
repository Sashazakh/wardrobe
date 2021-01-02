import UIKit
import PinLayout

final class WardrobeDetailViewController: UIViewController {
	var output: WardrobeDetailViewOutput?

    private weak var headerView: UIView!
    private weak var titleLabel: UILabel!
    private weak var backButton: UIButton!
    private weak var actionButton: UIButton!
    private weak var collectionView: UICollectionView!
    private weak var dropDownTableView: DropDownView!
    private var tapOnMainViewGestureRecognizer: UITapGestureRecognizer!
    private var tapOnHeaderViewGestureRecognizer: UITapGestureRecognizer!

    private let screenBounds = UIScreen.main.bounds

    private var didTap: Bool = true

    private var isReloadDataNeed: Bool = false

	override func viewDidLoad() {
		super.viewDidLoad()

        setupViews()
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        output?.didLoadView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupLayout()
    }

    private func setupViews() {
        setupHeaderView()
        setupTitleLabel()
        setupBackButton()
        setupPersonButton()
        setupMainView()
        setupCollectionView()
        setupDropDownView()
        setupGestureRecognizers()
    }

    private func setupLayout() {
        setupHeaderViewLayout()
        setupTitleLableLayout()
        setupBackButtonLayout()
        setupPersonButtonLayout()
        setupCollectionLayout()
        setupFlowLayout()
    }

    // MARK: Settuping views

    private func setupMainView() {
        view.backgroundColor = GlobalColors.backgroundColor
    }

    private func setupHeaderView() {
        let viewHeader = UIView(frame: .zero)
        headerView = viewHeader
        headerView.backgroundColor = GlobalColors.mainBlueScreen
//        headerView.dropShadow()
//        headerView.roundLowerCorners(40)
        view.addSubview(headerView)
    }

    private func setupTitleLabel() {
        let title = UILabel()
        titleLabel = title
        titleLabel.textAlignment = .center
        titleLabel.text = "Гардероб \n"
        titleLabel.font = UIFont(name: "DMSans-Bold", size: 25)
        titleLabel.textColor = GlobalColors.backgroundColor
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.1
        titleLabel.numberOfLines = 2
        titleLabel.sizeToFit()
        headerView.addSubview(titleLabel)
    }

    private func setupBackButton() {
        let btn = UIButton()
        backButton = btn
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = GlobalColors.backgroundColor
        backButton.contentVerticalAlignment = .fill
        backButton.contentHorizontalAlignment = .fill
        backButton.addTarget(self, action: #selector(didBackButtonTapped(_:)), for: .touchUpInside)
        headerView.addSubview(backButton)
    }

    private func setupPersonButton() {
        let btn = UIButton()
        actionButton = btn
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold)
        actionButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        actionButton.setImage(UIImage(named: "more"), for: .normal)
        actionButton.tintColor = GlobalColors.backgroundColor
        actionButton.contentVerticalAlignment = .fill
        actionButton.contentHorizontalAlignment = .fill
        actionButton.addTarget(self, action: #selector(dropDownMenuTap(_:)), for: .touchUpInside)
        headerView.addSubview(actionButton)
    }

    private func setupCollectionView() {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView = collection
        collectionView.backgroundColor = .white
        collectionView.register(DetailViewCell.self,
                                forCellWithReuseIdentifier: "WardrobeDetail")
        collectionView.register(AddWardrobeCell.self, forCellWithReuseIdentifier: AddWardrobeCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
    }

    private func setupDropDownView() {
        let drop = DropDownView()
        dropDownTableView = drop
        dropDownTableView.output = output
        dropDownTableView.dropShadow()
        dropDownTableView.isUserInteractionEnabled = true
        view.addSubview(dropDownTableView)
    }

    private func setupGestureRecognizers() {
        tapOnMainViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dropDownMenuTap(_:)))
        self.view.isUserInteractionEnabled = true
        tapOnMainViewGestureRecognizer.isEnabled = false
        tapOnMainViewGestureRecognizer.numberOfTouchesRequired = 1
        collectionView.addGestureRecognizer(tapOnMainViewGestureRecognizer)

        tapOnHeaderViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dropDownMenuTap(_:)))
        tapOnHeaderViewGestureRecognizer.cancelsTouchesInView = true
        tapOnHeaderViewGestureRecognizer.isEnabled = false
        tapOnHeaderViewGestureRecognizer.numberOfTouchesRequired = 1
        headerView.addGestureRecognizer(tapOnHeaderViewGestureRecognizer)
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
            .vCenter()
            .width(70%)
            .height(50%)
    }

    private func setupBackButtonLayout() {
        backButton.pin
            .height(titleLabel.frame.height * 0.364)
            .width(5%)
            .vCenter()
            .left(3%)
    }

    private func setupPersonButtonLayout() {
        actionButton.sizeToFit()
        actionButton.pin
            .vCenter()
            .right(4.8%)
            .height(28)
            .width(31)
    }

    private func setupCollectionLayout() {
        collectionView.pin
            .below(of: headerView)
            .right()
            .left()
            .bottom()
    }

    private func setupFlowLayout() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let marginSides = screenBounds.width * 0.1
            let marginBottom = screenBounds.height * 0.041
            flowLayout.minimumInteritemSpacing = marginBottom
            flowLayout.minimumLineSpacing = marginSides
            flowLayout.scrollDirection = .vertical
        }
    }

    // MARK: Drop down menu functions

    private func showDropDownMenu() {
        dropDownTableView.pin
            .below(of: actionButton)
            .marginTop(20)
            .right(10)
            .height(0)
            .width(0)
        UIView.animate(withDuration: 0.5) {
            self.dropDownTableView.pin
                .below(of: self.actionButton)
                .marginTop(20)
                .right(10)
                .height(100)
                .width(160)
            self.view.layoutIfNeeded()
        }
        didTap = !didTap
    }

    private func hideDropDownMenu() {
        dropDownTableView.pin
            .below(of: actionButton)
            .marginTop(20)
            .right(10)
            .height(100)
            .width(160)
        UIView.animate(withDuration: 0.5) {
            self.dropDownTableView.pin
                .below(of: self.actionButton)
                .marginTop(20)
                .right(10)
                .height(0)
                .width(0)
            self.view.layoutIfNeeded()
        }
        didTap = !didTap
    }

    private func enableGesture() {
        tapOnMainViewGestureRecognizer.isEnabled = true
        tapOnHeaderViewGestureRecognizer.isEnabled = true
    }

    private func disableGesture() {
        tapOnMainViewGestureRecognizer.isEnabled = false
        tapOnHeaderViewGestureRecognizer.isEnabled = false
    }

    // MARK: Button actions

    @objc func dropDownMenuTap(_ sender: Any) {
        guard let isEditing = output?.isEditButtonTapped() else { return }
        if isEditing {
            output?.didEditButtonTap()
            didTap = !didTap
        } else {
            if didTap {
                enableGesture()
                showDropDownMenu()
            } else {
                disableGesture()
                hideDropDownMenu()
            }
        }
    }

    @objc func didBackButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WardrobeDetailViewController: WardrobeDetailViewInput {
    func hideDropMenu() {
        disableGesture()
        hideDropDownMenu()
    }

    func reloadDataWithAnimation() {
        isReloadDataNeed = true
        collectionView.reloadData()
    }

    func changeEditButton(state: EditButtonState) {
        switch state {
        case .edit:
            actionButton.setImage(UIImage(named: "more"), for: .normal)
        case .accept:
            actionButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
    }

    func setWardrobeName(with name: String) {
        guard var text = titleLabel.text else { return }
        text += "\"\(name)\""
        titleLabel.text = text
    }

    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }

    func reloadData() {
        collectionView.reloadData()
    }
}

extension WardrobeDetailViewController: UICollectionViewDelegate,
                                        UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var totalNumberOfCells = output?.getNumberOfLooks() ?? 0
        totalNumberOfCells += 1
        return totalNumberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var numberOfLooks = output?.getNumberOfLooks() ?? 0
        numberOfLooks += 1
        if indexPath.row == numberOfLooks - 1 || numberOfLooks == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddWardrobeCell.identifier, for: indexPath)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WardrobeDetail", for: indexPath) as? DetailViewCell else {
                return UICollectionViewCell()
            }

            guard let look = output?.look(at: indexPath) else {
                return UICollectionViewCell()
            }

            cell.configureCell(with: look, output: output)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)
    -> CGSize {
        return GlobalConstants.cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int)
    -> UIEdgeInsets {
        let marginSides = screenBounds.width * 0.1
        let marginTop = screenBounds.height * 0.05
        return UIEdgeInsets(top: marginTop, left: marginSides, bottom: 5, right: marginSides)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.4) {
                cell.transform = CGAffineTransform.identity
            }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var numberOfWardobes = output?.getNumberOfLooks() ?? 0
        numberOfWardobes += 1
        if indexPath.row == numberOfWardobes - 1 || numberOfWardobes == 0 {
            output?.didTapCreateLookCell()
        } else {
            output?.didTapLook(at: indexPath)
        }
    }
}
