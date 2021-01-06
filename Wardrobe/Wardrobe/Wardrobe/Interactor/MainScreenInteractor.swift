import Foundation
import Kingfisher

final class MainScreenInteractor {
	weak var output: MainScreenInteractorOutput?

    private func handleError(with error: NetworkError) {
        switch error {
        case .networkNotReachable:
            self.output?.showAlert(title: "Ошибка", message: "Не удается подключиться")
        default:
            self.output?.showAlert(title: "Ошибка", message: "Мы скоро все починим")
        }
    }

    private func handleWardrobes(with wardrobeRaw: [WardrobeRaw]) {
        let wardobes: [WardrobeData] = wardrobeRaw.map({ WardrobeData(with: $0) })
        output?.didReceive(with: wardobes)
    }
}

extension MainScreenInteractor: MainScreenInteractorInput {
    func getUserLogin() -> String {
        guard let userLogin = DataService.shared.getUserLogin() else { return "" }
        return userLogin
    }

    func deleteWardrobe(with id: Int) {
        DataService.shared.deleteWardrobe(with: id) { [weak self] result in
            guard let self = self else { return }

            if let error = result.error {
                self.handleError(with: error)
                return
            }

            self.output?.didDelete()
        }
    }

    func loadUserWardobes() {
        DataService.shared.getUserWardrobes { [weak self] result in
            guard let self = self else { return }

            if let error = result.error {
                self.handleError(with: error)
                return
            }

            guard let wardobes = result.data else {
                return
            }

            self.handleWardrobes(with: wardobes)
        }
    }

    func loadUserData() {
        let name = AuthService.shared.getUserName()
        let image = AuthService.shared.getUserImageURL()
        output?.didReceive(name: name, imageUrl: image)
    }

    func cleanImageCache(for models: [WardrobeData]) {
        for model in models {
            if let urlString = model.imageUrl {
                let cacheKey = urlString
                KingfisherManager.shared.cache.removeImage(forKey: cacheKey)
            }
        }
    }
}
