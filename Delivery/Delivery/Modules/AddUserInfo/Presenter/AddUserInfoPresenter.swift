//
//  AddUserInfoPresenter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 16.02.23.
//

import Foundation

protocol AddUserInfoPresenterProtocol {
    
}

class AddUserInfoPresenter: AddUserInfoPresenterProtocol {
    
    private(set) var view: AddUserInfoVCProtocol?
    private(set) var router: AddUserInfoRouterProtocol?
    
    
    required init(view: AddUserInfoVCProtocol, router: AddUserInfoRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    
}
