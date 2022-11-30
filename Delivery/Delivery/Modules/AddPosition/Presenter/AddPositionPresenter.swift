//
//  AddPositionPresenter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 26.11.22.
//

import Foundation
import UIKit

protocol AddPositionPresenterProtocol {
    // Func for close VC
    func closeVC(viewController: UIViewController)
    
    // Func for add menu position on realm and basket
    func addPositionInBasket()
    
    // Tap plus button on VC
    func plusPosition()
    
    // Tap minus button on VC
    func minusPosition()
}

class AddPositionPresenter: AddPositionPresenterProtocol {

    private(set) var view: AddPositionVCProtocol?
    private(set) var router: AddPositionRouterProtocol?
    private(set) var realmService: RealmServiceProtocol?
    private(set) var menuInfo: Menu
    private(set) var image: UIImage
    private(set) var countPosition: Int = 1 

    required init(view: AddPositionVCProtocol, router: AddPositionRouterProtocol, menuInfo: Menu, image: UIImage, realmService: RealmServiceProtocol) {
        self.realmService = realmService
        self.image = image
        self.menuInfo = menuInfo
        self.router = router
        self.view = view
        view.configureVC(menuInfo: menuInfo, image: image)
        view.changeCountLabel(value: countPosition)
        realmService.realmUrl()
    }
    
    // Func for close VC
    func closeVC(viewController: UIViewController) {
        viewController.dismiss(animated: true)
    }
    
    // Func for add menu position on realm and basket
    func addPositionInBasket() {
        guard let realmService else { return }
        realmService.addPositionInBasket(menuInfo: menuInfo, countPosition: 3)
    }
    
    // Tap plus button on VC
    func plusPosition() {
        guard let view else { return }
        countPosition += 1
        view.changeCountLabel(value: countPosition)
    }
    
    // Tap minus button on VC
    func minusPosition() {
        guard let view else { return }
        countPosition -= 1
        view.changeCountLabel(value: countPosition)
    }
    
}
