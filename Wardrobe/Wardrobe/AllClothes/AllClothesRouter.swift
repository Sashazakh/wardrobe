import UIKit

final class AllClothesRouter {
    weak var viewController: UIViewController?
}

extension AllClothesRouter: AllClothesRouterInput {
    func showAlert(title: String, message: String) {
        guard let view = viewController else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)

        alert.addAction(okAction)

        view.present(alert, animated: true, completion: nil)
    }

    func showEditItemScreen(itemId: Int) {
        let editItemVC = EditItemContainer.assemble(with: EditItemContext(itemID: itemId)).viewController

        editItemVC.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(editItemVC, animated: true)
    }

    func showAddItemScreen(category: String) {
        let newItemVC = NewItemScreenContainer.assemble(with: NewItemScreenContext(category: category)).viewController

        newItemVC.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(newItemVC, animated: true)
    }

    func showNewCategoryAlert(complition: @escaping (String) -> Void) {
        guard let view = viewController else { return }
        let alert = UIAlertController(title: "Новая категория",
                                      message: "Введите имя новой категории",
                                      preferredStyle: UIAlertController.Style.alert)
        let save = UIAlertAction(title: "Сохранить", style: .default) { (_) in
            var correctName = ""
            if let nameTextField = alert.textFields?[0] {
                if let name = nameTextField.text {
                    if !name.isEmpty {
                            correctName = name
                        }
                    }
                }
            complition(correctName)
        }
            alert.addTextField { (textField) in
                textField.placeholder = "Название категории"
            }
            alert.addAction(save)
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
            alert.addAction(cancel)
            view.present(alert, animated: true, completion: nil)
    }
}
