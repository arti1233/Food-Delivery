//
//  MenuRouter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

protocol BaseMenuProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol MenuRouterProtocol: BaseMenuProtocol {
    func showAddPositionVC(menuInfo: Menu, image: UIImage)
    func showSlideMenuVC()
}

class MenuRouter: MenuRouterProtocol {
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
    
    func showSlideMenuVC() {
        guard let view = builder?.createSlideMenuVC(),
              let viewController else { return }
        view.modalPresentationStyle = .overFullScreen
        viewController.present(view, animated: false)
    }
}
