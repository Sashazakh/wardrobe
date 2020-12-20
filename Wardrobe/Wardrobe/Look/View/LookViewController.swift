import UIKit
import PinLayout

final class LookViewController: UIViewController {
	var output: LookViewOutput?

    private weak var backgroundView: UIView!

    private weak var lookName: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()

        setupView()
        setupSubviews()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutBackgroundView()
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupSubviews() {
        setupBackgroundView()
        setupLookName()
    }

    private func setupBackgroundView() {
        let background = UIView()

        backgroundView = background
        view.addSubview(backgroundView)

        backgroundView.backgroundColor = GlobalColors.mainBlueScreen
        backgroundView.dropShadow()
        backgroundView.roundLowerCorners(35)
    }

    private func setupLookName() {
        let label = UILabel()
        
        lookName = label
        view.addSubview(lookName)
        
        
        DMSans-Bold-25
    }

    private func layoutBackgroundView() {
        backgroundView.pin
            .top(.zero)
            .width(100%)
            .height(10%)
    }
}

extension LookViewController: LookViewInput {
}
