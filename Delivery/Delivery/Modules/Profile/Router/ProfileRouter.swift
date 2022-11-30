//
//  ProfileRouter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

protocol BaseProfileProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol ProfileRouterProtocol: BaseProfileProtocol {
    
}

class ProfileRouter: ProfileRouterProtocol {
    var builder: ModuleBuilderProtocol?
    var viewController: UIViewController?
    
    init(builder: ModuleBuilderProtocol, viewController: UIViewController) {
        self.builder = builder
        self.viewController = viewController
    }
}