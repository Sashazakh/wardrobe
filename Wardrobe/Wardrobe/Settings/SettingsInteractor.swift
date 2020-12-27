import Foundation

final class SettingsInteractor {
	weak var output: SettingsInteractorOutput?
}

extension SettingsInteractor: SettingsInteractorInput {
    func logout() {
        AuthService.shared.dropUser()
        output?.didAllKeysDeleted()
    }
}
