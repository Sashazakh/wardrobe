import Foundation
import UIKit

final class WardrobeDetailPresenter {
	weak var view: WardrobeDetailViewInput?

	private let router: WardrobeDetailRouterInput
	private let interactor: WardrobeDetailInteractorInput

    var wardrobeId: Int?
    var wardrobeName: String?
    var creatorLogin: String?

    var looks: [WardrobeDetailData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadDataWithAnimation()
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

    func didDeleteLookTap(with lookData: WardrobeDetailData) {
        let alert = UIAlertController(title: Constants.headDeleteWarningMessage,
                                      message: Constants.deleteWardrobeWarningMessage,
                                      preferredStyle: UIAlertController.Style.alert )
        let reset = UIAlertAction(title: "Удалить", style: .default) { [self] (_) in
            self.interactor.deleteLook(lookId: lookData.id)
        }
        alert.addAction(reset)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(cancel)
        view?.showAlert(alert: alert)
    }

    func refreshData() {
        interactor.cleanImageCache(for: looks)
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
        guard let id = wardrobeId,
              let name = wardrobeName,
              let loginOfCreator = creatorLogin else { return }
        router.showPersons(wardrobeId: id,
                           wardrobeName: name,
                           loginOfCreator: loginOfCreator)
    }

    func didTapLook(at indexPath: IndexPath) {
        guard let creatorLogin = creatorLogin else { return }
        router.showLookScreen(with: look(at: indexPath).id, creatorLogin: creatorLogin)
    }

    func didTapCreateLookCell() {
        guard let wardrobeId = wardrobeId else { return }
        guard let creatorLogin = creatorLogin else { return }
        router.showCreateLookScreen(wardrobeId: wardrobeId, creatorLogin: creatorLogin)
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

extension WardrobeDetailPresenter {
    private struct Constants {
        static let headDeleteWarningMessage: String = "Удаление набора"
        static let deleteWardrobeWarningMessage: String = "Вы собираетесь удалить набор.\n Все данные будут потеряны."
    }
}
