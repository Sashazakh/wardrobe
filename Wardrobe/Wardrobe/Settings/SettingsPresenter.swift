import Foundation
import UIKit

final class SettingsPresenter {
	weak var view: SettingsViewInput?

	private let router: SettingsRouterInput
	private let interactor: SettingsInteractorInput

    var userLogin: String?
    var userName: String?
    var imageUrl: String?
    init(router: SettingsRouterInput, interactor: SettingsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }

    private func setUserData() {
        view?.setUserData(name: userName, imageUrl: URL(string: imageUrl ?? ""))
    }
}

extension SettingsPresenter: SettingsViewOutput {
    func didLoadView() {
        setUserData()
    }

    func didImageLoaded(image: UIImage) {

    }
}

extension SettingsPresenter: SettingsInteractorOutput {
}
