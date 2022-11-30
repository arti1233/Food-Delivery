//
//  BasketPresenter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

protocol BasketPresenterProtocol: AnyObject {
    func configurePositionCell(menuInfo: Menu, image: UIImage, quantityPosition: Int)
}

class BasketPresenter: BasketPresenterProtocol {
    private(set) var view: BasketVCProtocol?
    private(set) var router: BasketRouterProtocol?
    
    required init(view: BasketVCProtocol, router: BasketRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func configurePositionCell(menuInfo: Menu, image: UIImage, quantityPosition: Int) {
        
    }
    
    
    
    
}
