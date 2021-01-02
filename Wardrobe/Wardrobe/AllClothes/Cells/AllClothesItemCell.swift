import Foundation

class AllClothesItemCell: WardrobeCell {
    var output: AllClothesViewOutput?

    func setData(data: ItemData) {
        self.titleLable.text = data.clothesName
        guard let url = URL(string: (data.imageURL ?? String()) + "&apikey=\(AuthService.shared.getApiKey())") else {
            return
        }
        self.imageView.kf.setImage(with: url)
    }
}
