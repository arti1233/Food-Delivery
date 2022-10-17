//
//  ProfilePresenter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    
}

class ProfilePresenter: ProfilePresenterProtocol {
    private(set) var view: ProfileVCProtocol?
    private(set) var router: ProfileRouterProtocol?
    
    required init(view: ProfileVCProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.router = router
    }
}
