//
//  AddPositionPresenter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 26.11.22.
//

import Foundation
import UIKit

protocol AddPositionPresenterProtocol {
    func closeVC(viewController: UIViewController)
    func addPositionInBasket()
    func plusPosition()
    func minusPosition()
}

class AddPositionPresenter: AddPositionPresenterProtocol {

    private(set) var view: AddPositionVCProtocol?
    private(set) var router: AddPositionRouterProtocol?
    private(set) var realmService: RealmServiceProtocol?
    private(set) var menuInfo: Menu
    private(set) var image: UIImage
    private(set) var countPosition: Int = 1
    private(set) var basketRealm: Basket?
    
    required init(view: AddPositionVCProtocol, router: AddPositionRouterProtocol, menuInfo: Menu, image: UIImage, realmService: RealmServiceProtocol) {
        self.realmService = realmService
        self.image = image
        self.menuInfo = menuInfo
        self.router = router
        self.view = view
        basketRealm = realmService.isThereElementInRealm(menuInfo: menuInfo)
        if let basketRealm {
            guard let cost = menuInfo.cost else { return }
            view.configureVC(menuInfo: menuInfo, image: image)
            countPosition = basketRealm.countPosition
            view.changeCountLabel(value: basketRealm.countPosition, cost: basketRealm.countPosition * cost)
        } else {
            guard let cost = menuInfo.cost else { return }
            view.configureVC(menuInfo: menuInfo, image: image)
            view.changeCountLabel(value: countPosition, cost: countPosition * cost)
        }
    }

    func closeVC(viewController: UIViewController) {
        viewController.dismiss(animated: true)
    }
    
    func addPositionInBasket() {
        guard let realmService else { return }
        realmService.addPositionInBasket(menuInfo: menuInfo, countPosition: countPosition)
    }
    
    func plusPosition() {
        guard let view, let cost = menuInfo.cost else { return }
        countPosition += 1
        view.changeStatusButton(isMinusButton: true, isPlusButton: true)
        view.changeCountLabel(value: countPosition, cost: countPosition * cost)
    }
    
    func minusPosition() {
        guard let view, let cost = menuInfo.cost else { return }
        if countPosition - 1 >= 1 {
            countPosition -= 1
            view.changeCountLabel(value: countPosition, cost: countPosition * cost)
        }
        
        if countPosition == 1 {
            view.changeStatusButton(isMinusButton: false, isPlusButton: true)
        }
    }
}
 
