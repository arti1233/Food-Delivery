//
//  BasketRouter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

protocol BaseBasketProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol BasketRouterProtocol: BaseBasketProtocol {
    func showAddPositionVC(menuInfo: Menu, image: UIImage)
    func showOrderRegistrationVC()
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
}
