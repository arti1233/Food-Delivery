//
//  ModuleBuilder.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    func createMenuVC(title: String, image: UIImage?) -> UIViewController
    func createProfileVC(title: String, image: UIImage?) -> UIViewController
    func createBasketVC(title: String, image: UIImage?) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    func createMenuVC(title: String, image: UIImage?) -> UIViewController {
        let view = MenuVC()
        let alamofireProtocol = AlamofireProvider()
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        let router = MenuRouter(builder: self, viewController: view)
        let presenter = MenuPresenter(view: view, router: router, alamofireProvider: alamofireProtocol)
        view.presenter = presenter
        return view
    }
    
    func createProfileVC(title: String, image: UIImage?) -> UIViewController {
        let view = ProfileVC()
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        let router = ProfileRouter(builder: self, viewController: view)
        let presenter = ProfilePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createBasketVC(title: String, image: UIImage?) -> UIViewController {
        let view = BasketVC()
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        let router = BasketRouter(builder: self, viewController: view)
        let presenter = BasketPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
