import Foundation
import UIKit

protocol WardrobeDetailViewInput: class {
    func showAlert(alert: UIAlertController)
    func reloadData()
}

protocol WardrobeDetailViewOutput: class {
    func personDidTap()
    func didTapLook(at indexPath: IndexPath)
    func didTapCreateLookCell()
    func didLoadView()
    func getNumberOfLooks() -> Int
    func look(at indexPath: IndexPath) -> WardrobeDetailData
}

protocol WardrobeDetailInteractorInput: class {
    func loadLooks(with wardrobeId: Int)
}

protocol WardrobeDetailInteractorOutput: class {
    func didReceive(with: [WardrobeDetailData])
    func showAlert(title: String, message: String)

}

protocol WardrobeDetailRouterInput: class {
    func showPersons(with wardrobeId: Int)
    func showLookScreen(with lookId: Int)
    func showCreateLookScreen()
}
