import UIKit
import Foundation


// MARK: UITableViewCell
extension UITableViewCell {
    var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}



// MARK: UITextField
extension UITextField {
    static func customTextField(placeholder: String, fontsize: CGFloat = 15) -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        textField.clipsToBounds = true
        textField.textColor = .black
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.backgroundColor = UIColor.white
        textField.font = UIFont(name: "DMSans-Regular", size: fontsize)

        textField.leftView = UIView(frame: CGRect(x: .zero,
                                                      y: .zero,
                                                      width: 10,
                                                      height: .zero))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: .zero,
                                                       y: .zero,
                                                       width: 10,
                                                       height: .zero))
        textField.rightViewMode = .unlessEditing

        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .no
        return textField
    }
}

// MARK: UIView
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


// MARK: UIImage
extension UIImage {
    
    // MARK: Make image opacity
    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
}