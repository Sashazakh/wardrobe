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
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }

    private var isLoadView: Bool = false

    private var isUserEditButtonTapped: Bool = false

    init(router: WardrobeDetailRouterInput, interactor: WardrobeDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension WardrobeDetailPresenter: WardrobeDetailViewOutput {
    func didEditLookTap(at indexPath: IndexPath) {
        router.showEditLook(with: looks[indexPath.row].id)
    }

    func didDeleteLookTap(lookId: Int) {
        interactor.deleteLook(lookId: lookId)
    }

    func refreshData() {
        guard let wardrobeId = wardrobeId else { return }
        interactor.loadLooks(with: wardrobeId)
    }

    func didEditButtonTap() {
        view?.hideDropMenu()
        isUserEditButtonTapped = !isUserEditButtonTapped
        view?.reloadDataWithAnimation()
        if isEditButtonTapped() {
            view?.changeEditButton(state: .accept)
        } else {
            view?.changeEditButton(state: .edit)
        }
    }

    func isEditButtonTapped() -> Bool {
        return isUserEditButtonTapped
    }

    func look(at indexPath: IndexPath) -> WardrobeDetailData {
        return looks[indexPath.row]
    }

    func getNumberOfLooks() -> Int {
        return looks.count
    }

    func didLoadView() {
        if let name = wardrobeName, !isLoadView {
            view?.setWardrobeName(with: name)
        }
        guard let id = wardrobeId else { return }
        interactor.loadLooks(with: id)
        isLoadView = true
    }

    func didPersonTap() {
        view?.hideDropMenu()
        guard let id = wardrobeId, let name = wardrobeName else { return }
        router.showPersons(wardrobeId: id, wardrobeName: name)
    }

    func didTapLook(at indexPath: IndexPath) {
        router.showLookScreen(with: look(at: indexPath).id)
    }

    func didTapCreateLookCell() {
        guard let wardrobeId = wardrobeId else { return }
        router.showCreateLookScreen(with: wardrobeId)
    }
}

extension WardrobeDetailPresenter: WardrobeDetailInteractorOutput {
    func didDelete() {
        guard let wardrobeId = wardrobeId else { return }
        interactor.loadLooks(with: wardrobeId)
    }

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
