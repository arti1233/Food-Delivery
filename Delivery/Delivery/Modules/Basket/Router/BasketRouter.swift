import Foundation
import UIKit

protocol BaseBasketProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol BasketRouterProtocol: BaseBasketProtocol {
    func showAddPositionVC(menuInfo: Menu, image: UIImage)
    func showOrderRegistrationVC()
    func showSlideMenuVC(tabBarController: UITabBarController)
}

class BasketRouter: BasketRouterProtocol {
    var builder: ModuleBuilderProtocol?
    var viewController: UIViewController?
    
    init(builder: ModuleBuilderProtocol, viewController: UIViewController) {
        self.builder = builder
        self.viewController = viewController
    }
    
    func showAddPositionVC(menuInfo: Menu, image: UIImage) {
        guard let view = builder?.createAddPositionVC(menuInfo: menuInfo, image: image),
              let viewController else { return }
        view.modalPresentationStyle = .overFullScreen
        viewController.present(view, animated: true)
    }
    
    func showOrderRegistrationVC() {
        guard let view = builder?.createOrderRegistrationVC(),
              let viewController else { return }
        viewController.present(view, animated: true)
    }
    
    func showSlideMenuVC(tabBarController: UITabBarController) {
        guard let view = builder?.createSlideMenuVC(tabBarController: tabBarController),
              let viewController else { return }
        view.modalPresentationStyle = .overFullScreen
        viewController.present(view, animated: false)
    }
}
