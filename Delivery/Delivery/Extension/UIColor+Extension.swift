import Foundation
import UIKit

extension UIColor {
    static var basicBackgroundColor: UIColor {
        guard let color = UIColor(named: "basicBackgroundColor") else {
            return UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        }
        return color
    }
}
