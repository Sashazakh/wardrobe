import UIKit
import PinLayout

final class SplashScreenViewController: UIViewController {

    private weak var splashScreenImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSubviews()
        sleep(Constants.sleepTime)
    }

    private func setupView() {
        view.backgroundColor = GlobalColors.mainBlueScreen
    }

    private func setupSubviews() {
        setupSplashScreenImageView()
    }

    private func setupSplashScreenImageView() {
        let imageView = UIImageView()

        splashScreenImageView = imageView
        view.addSubview(imageView)

        splashScreenImageView.image = UIImage(named: "dresser")
        splashScreenImageView.contentMode = .scaleToFill
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        layoutSplashScreenImageView()
    }

    private func layoutSplashScreenImageView() {
        splashScreenImageView.pin
            .hCenter()
            .width(76%)
            .height(33%)

        splashScreenImageView.pin
            .top(view.bounds.midY * 1.15 - splashScreenImageView.bounds.height / 2)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)

        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
}

extension SplashScreenViewController {
    struct Constants {
        static let sleepTime: UInt32 = 2
    }
}
