//
//  OrderRegistrationPresenter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 7.12.22.
//

import Foundation
import UIKit

protocol OrderRegistrationPresenterProtocol {
    
}

class OrderRegistrationPresenter: OrderRegistrationPresenterProtocol {
    
    private(set) var view: OrderRegistrationVCProtocol?
    private(set) var router: OrderRegistrationRouterProtocol?
    
    required init(view: OrderRegistrationVCProtocol, router: OrderRegistrationRouterProtocol) {
        self.view = view
        self.router = router
    }
}
