import UIKit

extension UIView {
    func dropShadow(offset: CGSize = CGSize(width: 1, height: 3), radius: CGFloat = 4, opacity: Float = 0.4) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
    }

    func roundLowerCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
