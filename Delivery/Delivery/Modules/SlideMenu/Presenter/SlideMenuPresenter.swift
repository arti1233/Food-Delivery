import Foundation
import UIKit

protocol SlideMenuPresenterProtocol: AnyObject {
    func closeVC(viewController: UIViewController)
    func goToMenuButtonTapped()
    func goToProfileButtonTapped()
    func goToBasketButtonTapped()
}

class SlideMenuPresenter: SlideMenuPresenterProtocol {
    
    private(set) var view: SlideMenuVCProtocol?
    private(set) var router: SlideMenuRouterProtocol?
    private(set) var tabBarController: UITabBarController?
    
    required init(view: SlideMenuVCProtocol, router: SlideMenuRouterProtocol, tabBarController: UITabBarController) {
        self.view = view
        self.router = router
        self.tabBarController = tabBarController
    }
    
    func closeVC(viewController: UIViewController) {
        viewController.dismiss(animated: false)
    }
    
    func goToMenuButtonTapped() {
        guard let tabBarController else { return }
        tabBarController.selectedIndex = 0
    }
    
    func goToProfileButtonTapped() {
        guard let tabBarController else { return }
        tabBarController.selectedIndex = 1
    }
    
    func goToBasketButtonTapped() {
        guard let tabBarController else { return }
        tabBarController.selectedIndex = 2
    }
}
