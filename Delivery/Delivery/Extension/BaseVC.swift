import Foundation
import UIKit

class BaseVC: UIViewController {
    
    //MARK: Standart setting for UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        guard let navigationController else { return }
        navigationController.navigationBar.barTintColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
}
