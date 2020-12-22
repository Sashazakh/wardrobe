import UIKit
import Foundation

struct GlobalConstants {
    static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }

    static var cellSize: CGSize {
        let width = GlobalConstants.screenBounds.width * 0.33
        let height = width * 2
        return CGSize(width: width, height: height)
    }
}
