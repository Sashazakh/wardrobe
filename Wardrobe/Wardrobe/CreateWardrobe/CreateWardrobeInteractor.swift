//
//  CreateWardrobeInteractor.swift
//  Wardrobe
//
//  Created by kymblc on 19.12.2020.
//  
//

import Foundation

final class CreateWardrobeInteractor {
	weak var output: CreateWardrobeInteractorOutput?

    private func handleError(with error: Error) {
        guard let networkError = error as? NetworkError else { return }

        switch networkError {
        case .networkNotReachable:
            self.output?.showAlert(title: "Ошибка", message: "Не удается подключиться")
        case .userNotExist:
            self.output?.showAlert(title: "Ошибка", message: "Пользователь не найден")
        default:
            self.output?.showAlert(title: "Ошибка", message: "Мы скоро все починим")
        }
    }
}

extension CreateWardrobeInteractor: CreateWardrobeInteractorInput {
    func addWardrobe(with wardrobe: CreateWardobeData, for user: String) {

        DataService.shared.addWardrobe(name: wardrobe.name, description: wardrobe.description, imageData: wardrobe.imageData) {  [weak self] result in
            guard let self = self else { return }

            if let error = result.error {
                self.handleError(with: error)
                return
            }

            self.output?.successLoadWardobe()
        }
    }
}
