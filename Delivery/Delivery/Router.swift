//
//  Router.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

protocol BaseRouter {
    var navigationTabBarController: UITabBarController? { get set }
    var builder: ModuleBuilderProtocol? { get set }
}

protocol ViewsRouterProtocol: BaseRouter {
    func initialViewControllers()
}

class Router: ViewsRouterProtocol {
    var navigationTabBarController: UITabBarController?
    var builder: ModuleBuilderProtocol?
    
    init(navigationTabBarController: UITabBarController, builder: ModuleBuilderProtocol) {
        self.navigationTabBarController = navigationTabBarController
        self.builder = builder
    }
    
    func initialViewControllers() {
        guard let builder = builder, let navigationTabBarController = navigationTabBarController else { return }
        let menuVC = UINavigationController(rootViewController: builder.createMenuVC(title: "Menu", image: UIImage(named: "menu")))
        let profileVC = UINavigationController(rootViewController: builder.createProfileVC(title: "Profile", image: UIImage(systemName: "person.fill")))
        let basketVC = UINavigationController(rootViewController: builder.createBasketVC(title: "Basket", image: UIImage(named: "CustomBasket")))
        navigationTabBarController.viewControllers = [menuVC, profileVC, basketVC]
    }
}
