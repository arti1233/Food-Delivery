import Foundation
import UIKit

class BaseVC: UIViewController {
    
    //MARK: Standart setting for UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .basicBackgroundColor
        guard let navigationController else { return }
        navigationController.navigationBar.barTintColor = .basicBackgroundColor
    }
}
