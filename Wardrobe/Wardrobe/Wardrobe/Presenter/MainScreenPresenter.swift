//
//  MainScreenPresenter.swift
//  Wardrobe
//
//  Created by  Alexandr Zakharov on 18.12.2020.
//  
//

import UIKit

final class MainScreenPresenter {
	weak var view: MainScreenViewInput?

	private let router: MainScreenRouterInput
	private let interactor: MainScreenInteractorInput

    private var userWardrobes: [WardrobeData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadDataWithAnimation()
            }
        }
    }

    private var isUserEditButtonTapped: Bool = false

    var userName: String?
    var userLogin: String?
    var imageUrlString: String?

    init(router: MainScreenRouterInput, interactor: MainScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }

    private func isCreator(modelLogin: String) -> Bool {
        let userLogin = interactor.getUserLogin()
        return modelLogin == userLogin ? true : false
    }
}

extension MainScreenPresenter: MainScreenViewOutput {
    func didEditWardrobeTap(at indexPath: IndexPath) {
        router.showEditWardrobe(with: userWardrobes[indexPath.row].id)
    }

    func refreshData() {
        interactor.cleanImageCache(for: userWardrobes)
        interactor.loadUserWardobes()
    }

    func didDeleteWardrobeTap(with wardrobe: WardrobeData) {
        let message = isCreator(modelLogin: wardrobe.wardrobeOwner)
            ? Constants.deleteWardrobeWarningCreator : Constants.deleteWardrobeWarningNotCreator

        let alert = UIAlertController(title: Constants.headDeleteWarningMessage,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert )
        let reset = UIAlertAction(title: "Удалить", style: .default) { [self] (_) in
            self.interactor.deleteWardrobe(with: wardrobe.id)
        }
        alert.addAction(reset)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(cancel)
        view?.showAlert(alert: alert)
    }

    func didLoadView() {
        view?.startActivity()
        interactor.loadUserWardobes()
    }

    func addWardrobeDidTap() {
        router.showAddWardobeScreen(for: userLogin ?? "")
    }

    func didEditButtonTap() {
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

    func showDetailDidTap(at indexPath: IndexPath) {
        let wardobeData = userWardrobes[indexPath.row]
        router.showDetailWardrope(id: wardobeData.id,
                                  name: wardobeData.name,
                                  creatorLogin: wardobeData.wardrobeOwner)
    }

    func settingsButtonDidTap() {
        router.showSettings(login: userLogin ?? "", name: userName ?? "", imageUrl: imageUrlString ?? "")
    }

    func getNumberOfWardrobes() -> Int {
        return userWardrobes.count
    }

    func wardrobe(at indexPath: IndexPath) -> WardrobeData? {
        return userWardrobes[indexPath.row]
    }
}

extension MainScreenPresenter: MainScreenInteractorOutput {
    func showAlert(title: String, message: String) {
        view?.endActivity()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)

        alert.addAction(okAction)
        view?.showAlert(alert: alert)
    }

    func didReceive(with wardrobes: [WardrobeData]) {
        view?.endActivity()
        self.userWardrobes = wardrobes
    }

    func didDelete() {
        interactor.loadUserWardobes()
    }
}

extension MainScreenPresenter {
    struct Constants {
        static let headDeleteWarningMessage: String = "Удаление гардероба"
        static let deleteWardrobeWarningNotCreator: String = "Вы собираетесь удалить гардероб. Возратить его заново можно только по приглашению."
        static let deleteWardrobeWarningCreator: String = "Вы собираетесь удалить гардероб.  Все данные будут потеряны."
    }
}
