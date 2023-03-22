import Foundation
import UIKit

extension UIColor {
    static var basicBackgroundColor: UIColor {
        guard let color = UIColor(named: "basicBackgroundColor") else {
            return UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        }
        return color
    }
    
    static var basicButtonColor: UIColor {
        guard let color = UIColor(named: "basicButtonColor") else {
            return #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
        }
        return color
    }
    
    static var basicWhiteColor: UIColor {
        guard let color = UIColor(named: "basicButtonColor") else {
            return #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
        return color
    }
}
