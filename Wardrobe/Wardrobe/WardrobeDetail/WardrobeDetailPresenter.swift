import Foundation
import UIKit

final class WardrobeDetailPresenter {
	weak var view: WardrobeDetailViewInput?

	private let router: WardrobeDetailRouterInput
	private let interactor: WardrobeDetailInteractorInput

    var wardrobeId: Int?
    var wardrobeName: String?

    var looks: [WardrobeDetailData] = [] {
        didSet {
            view?.reloadData()
        }
    }

    init(router: WardrobeDetailRouterInput, interactor: WardrobeDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension WardrobeDetailPresenter: WardrobeDetailViewOutput {
    func look(at indexPath: IndexPath) -> WardrobeDetailData {
        return looks[indexPath.row]
    }

    func getNumberOfLooks() -> Int {
        return looks.count
    }

    func didLoadView() {
        if let name = wardrobeName {
            view?.setWardrobeName(with: name)
        }
        guard let id = wardrobeId else { return }
        interactor.loadLooks(with: id)
    }

    func personDidTap() {
        guard let id = wardrobeId, let name = wardrobeName else { return }
        router.showPersons(wardrobeId: id, wardrobeName: name)
    }

    func didTapLook(at indexPath: IndexPath) {
        router.showLookScreen(with: look(at: indexPath).id)
    }

    func didTapCreateLookCell() {
        router.showCreateLookScreen()
    }
}

extension WardrobeDetailPresenter: WardrobeDetailInteractorOutput {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)

        alert.addAction(okAction)
        view?.showAlert(alert: alert)
    }

    func didReceive(with looks: [WardrobeDetailData]) {
        self.looks = looks
    }
}
