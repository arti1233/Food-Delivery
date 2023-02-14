import Foundation
import UIKit

protocol BaseProfileProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol ProfileRouterProtocol: BaseProfileProtocol {
    func showSlideMenuVC(tabBarController: UITabBarController)
}

class ProfileRouter: ProfileRouterProtocol {
    var builder: ModuleBuilderProtocol?
    var viewController: UIViewController?
    
    init(builder: ModuleBuilderProtocol, viewController: UIViewController) {
        self.builder = builder
        self.viewController = viewController
    }
    
    func showSlideMenuVC(tabBarController: UITabBarController) {
        guard let view = builder?.createSlideMenuVC(tabBarController: tabBarController),
              let viewController else { return }
        view.modalPresentationStyle = .overFullScreen
        viewController.present(view, animated: false)
    }
}
