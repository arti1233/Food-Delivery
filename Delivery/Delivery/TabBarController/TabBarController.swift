import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .purple
        tabBar.backgroundColor = .white
        tabBar.tintColor = .basicButtonColor
        tabBar.unselectedItemTintColor = .basicBackgroundColor
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = .zero
        tabBar.layer.shadowRadius = 5
    }
}
