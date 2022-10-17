//
//  MenuPresenter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

protocol MenuPresenterProtocol: AnyObject {
   
}

class MenuPresenter: MenuPresenterProtocol {
    
    private(set) var view: MenuVCProtocol?
    private(set) var router: MenuRouterProtocol?
    
    required init(view: MenuVCProtocol, router: MenuRouterProtocol) {
        self.view = view
        self.router = router
    }

}
