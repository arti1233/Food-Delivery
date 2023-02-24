import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    func createMenuVC(title: String, image: UIImage?) -> UIViewController
    func createProfileVC(title: String, image: UIImage?) -> UIViewController
    func createBasketVC(title: String, image: UIImage?) -> UIViewController
    func createAddPositionVC(menuInfo: Menu, image: UIImage) -> UIViewController
    func createOrderRegistrationVC() -> UIViewController
    func createSlideMenuVC(tabBarController: UITabBarController) -> UIViewController
    func createAddUserInfoVC() -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    func createMenuVC(title: String, image: UIImage?) -> UIViewController {
        let view = MenuVC()
        let alamofireProtocol = AlamofireProvider()
        let realmProtocol = RealmService()
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        let router = MenuRouter(builder: self, viewController: view)
        let presenter = MenuPresenter(view: view, router: router, alamofireProvider: alamofireProtocol, realmService: realmProtocol)
        view.presenter = presenter
        return view
    }
    
    func createProfileVC(title: String, image: UIImage?) -> UIViewController {
        let view = ProfileVC()
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        let router = ProfileRouter(builder: self, viewController: view)
        let realmService = RealmService()
        let presenter = ProfilePresenter(view: view, router: router, realmService: realmService)
        view.presenter = presenter
        return view
    }
    
    func createBasketVC(title: String, image: UIImage?) -> UIViewController {
        let view = BasketVC()
        let alamofireProtocol = AlamofireProvider()
        let realmProtocol = RealmService()
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        let router = BasketRouter(builder: self, viewController: view)
        let presenter = BasketPresenter(view: view, router: router, realmService: realmProtocol, alamofireService: alamofireProtocol)
        view.presenter = presenter
        return view
    }
    
    func createAddPositionVC(menuInfo: Menu, image: UIImage) -> UIViewController {
        let view = AddPositionVC()
        let router = AddPositionRouter(builder: self, viewController: view)
        let realmService = RealmService()
        let presenter = AddPositionPresenter(view: view, router: router, menuInfo: menuInfo, image: image, realmService: realmService)
        view.presenter = presenter
        return view
    }
    
    func createOrderRegistrationVC() -> UIViewController {
        let view = OrderRegistrationVC()
        let router = OrderRegistrationRouter(builder: self, viewController: view)
        let realmService = RealmService()
        let presenter = OrderRegistrationPresenter(view: view, router: router, realmService: realmService)
        view.presenter = presenter
        return view
    }
    
    func createSlideMenuVC(tabBarController: UITabBarController) -> UIViewController {
        let view = SlideMenuVC()
        let router = SlideMenuRouter(builder: self, viewController: view)
        let presenter = SlideMenuPresenter(view: view, router: router, tabBarController: tabBarController)
        view.presenter = presenter
        return view
    }
    
    func createAddUserInfoVC() -> UIViewController {
        let view = AddUserInfoVC()
        let router = AddUserInfoRouter(builder: self, viewController: view)
        let realmService = RealmService()
        let presenter = AddUserInfoPresenter(view: view, router: router, realmService: realmService)
        view.presenter = presenter
        return view
    }
}
