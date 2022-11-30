//
//  AddPositionRouter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 26.11.22.
//

import Foundation
import UIKit

protocol BaseAddPositionProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol AddPositionRouterProtocol: BaseAddPositionProtocol {
   
}

class AddPositionRouter: AddPositionRouterProtocol {
    var builder: ModuleBuilderProtocol?
    var viewController: UIViewController?
    
    init(builder: ModuleBuilderProtocol, viewController: UIViewController) {
        self.builder = builder
        self.viewController = viewController
    }
}
