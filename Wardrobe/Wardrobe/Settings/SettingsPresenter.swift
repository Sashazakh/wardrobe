import Foundation

final class SettingsPresenter {
	weak var view: SettingsViewInput?

	private let router: SettingsRouterInput
	private let interactor: SettingsInteractorInput

    init(router: SettingsRouterInput, interactor: SettingsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SettingsPresenter: SettingsViewOutput {
}

extension SettingsPresenter: SettingsInteractorOutput {
}