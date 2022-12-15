//
//  SlideMenuPresenter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 14.12.22.
//

import Foundation
import UIKit

protocol SlideMenuPresenterProtocol: AnyObject {
    func closeVC(viewController: UIViewController)
}

class SlideMenuPresenter: SlideMenuPresenterProtocol {
    
    private(set) var view: SlideMenuVCProtocol?
    private(set) var router: SlideMenuRouterProtocol?
    
    
    required init(view: SlideMenuVCProtocol, router: SlideMenuRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func closeVC(viewController: UIViewController) {
        viewController.dismiss(animated: false)
    }
}
