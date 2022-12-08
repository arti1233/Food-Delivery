//
//  OrderRegistrationRouter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 7.12.22.
//

import Foundation
import UIKit

protocol BaseOrderRegistrationProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol OrderRegistrationRouterProtocol: BaseOrderRegistrationProtocol {
    
}

class OrderRegistrationRouter: OrderRegistrationRouterProtocol {
    
    var builder: ModuleBuilderProtocol?
    var viewController: UIViewController?
    
    init(builder: ModuleBuilderProtocol, viewController: UIViewController) {
        self.builder = builder
        self.viewController = viewController
    }
}
