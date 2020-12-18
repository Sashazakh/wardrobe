import UIKit
import PinLayout

final class NewItemScreenViewController: UIViewController {
    private weak var headerView: UIView!
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
    }

    private func setupBackground() {
        self.view.backgroundColor = Constants.backgroundColor
    }

    private func setupHeaderView() {
        let view = UIView()
        self.headerView = view
        self.view.addSubview(headerView)
    }

    private func layoutUI() {
        layoutHeaderView()
    }

    private func layoutHeaderView() {
        headerView.backgroundColor = Constants.mainBlueScreen
        headerView.pin
            .top()
            .left()
            .right()
            .height(53%)
        headerView.clipsToBounds = false
        headerView.layer.cornerRadius = 30
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        headerView.dropShadow()
    }
}

extension NewItemScreenViewController: NewItemScreenViewInput {
}

extension NewItemScreenViewController {
    private struct Constants {
        static let backgroundColor = UIColor(red: 254 / 255,
                                    green: 254 / 255,
                                    blue: 253 / 255,
                                    alpha: 1)

        static let inputFillColor = UIColor(red: 247 / 255,
                                            green: 247 / 255,
                                            blue: 247 / 255,
                                            alpha: 1)

        static let photoFillColor = UIColor(red: 234 / 255,
                                           green: 234 / 255,
                                           blue: 234 / 255,
                                           alpha: 1)

        static let mainBlueScreen = UIColor(red: 128 / 255,
                                            green: 161 / 255,
                                            blue: 212 / 255,
                                            alpha: 1)
    }

}
