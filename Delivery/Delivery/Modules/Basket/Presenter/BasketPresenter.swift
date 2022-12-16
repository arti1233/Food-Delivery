//
//  BasketPresenter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit
import RealmSwift

protocol BasketPresenterProtocol: AnyObject {
    func configurePositionCell(indexPath: IndexPath, cell: CellFopBasketPosition)
    func getCountPosition() -> Int
    func getMenuInfoInPosition(indexPath: IndexPath)
    func minusButtonTapped(indexPath: IndexPath)
    func plusButtonTapped(indexPath: IndexPath)
    func nextStepButtonTapped()
    func showSlideMenu(tabBarController: UITabBarController)
    func goToMenuButtonTapped(tabBar: UITabBarController)
}

class BasketPresenter: BasketPresenterProtocol {
    private(set) var view: BasketVCProtocol?
    private(set) var router: BasketRouterProtocol?
    private(set) var realmService: RealmServiceProtocol?
    private(set) var alamofireService: AlamofireProtocol?
    private(set) var resultsBasket: Results<Basket>?
    private(set) var imageCache = NSCache<NSString, UIImage>()
    private(set) var notificationToken: NotificationToken?
    private(set) var totalSum: Int = 0
    
    required init(view: BasketVCProtocol, router: BasketRouterProtocol, realmService: RealmServiceProtocol, alamofireService: AlamofireProtocol) {
        self.view = view
        self.router = router
        self.realmService = realmService
        self.alamofireService = alamofireService
        resultsBasket = realmService.getAllPositionInBasket()
        view.isBasketEmpty(result: self.resultsBasket?.isEmpty ?? true)
        loadMenuImageToCache()
        getTotalSum()
        notificationToken = resultsBasket?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self else { return }
            switch changes {
            default :
                self.resultsBasket = realmService.getAllPositionInBasket()
                self.view?.isBasketEmpty(result: self.resultsBasket?.isEmpty ?? true)
                self.getTotalSum()
                self.loadMenuImageToCache()
            }
        }
    }
    
    func goToMenuButtonTapped(tabBar: UITabBarController) {
        tabBar.selectedIndex = 0
    }
    
    func showSlideMenu(tabBarController: UITabBarController) {
        guard let router else { return }
        router.showSlideMenuVC(tabBarController: tabBarController)
    }
    
    func nextStepButtonTapped() {
        guard let router else { return }
        router.showOrderRegistrationVC()
    }
    
    func getTotalSum() {
        guard let resultsBasket else { return }
        totalSum = 0
        for position in resultsBasket {
            guard let cost = position.cost else { return }
            totalSum += cost * position.countPosition
        }
    }
    
    func getMenuInfoInPosition(indexPath: IndexPath) {
        guard let router,
              let description = resultsBasket?[indexPath.row].descriptionPosition,
              let image = imageCache.object(forKey: (resultsBasket?[indexPath.row].image!)! as NSString),
              let imageString = resultsBasket?[indexPath.row].image,
              let name = resultsBasket?[indexPath.row].name,
              let cost = resultsBasket?[indexPath.row].cost else { return }
        let menuInfo = Menu(categoryID: [0], description: description, image: imageString, name: name, cost: cost)
        router.showAddPositionVC(menuInfo: menuInfo, image: image)
    }
    
    func configurePositionCell(indexPath: IndexPath, cell: CellFopBasketPosition) {
        guard let resultsBasket, let image = imageCache.object(forKey: resultsBasket[indexPath.row].image! as NSString) else { return }
        cell.configureCell(menuInfo: resultsBasket[indexPath.row], image: image)
    }
    
    func getCountPosition() -> Int {
        guard let count = realmService?.getAllPositionInBasket().count else { return 0 }
        return count
    }
    
    func minusButtonTapped(indexPath: IndexPath) {
        guard let resultsBasket = resultsBasket?[indexPath.row] else { return }
        if resultsBasket.countPosition - 1 == 0 {
            realmService?.deleteObject(basket: resultsBasket)
        } else {
            guard let descriptionPosition = resultsBasket.descriptionPosition,
                  let image = resultsBasket.image,
                  let name = resultsBasket.name,
                  let cost = resultsBasket.cost else { return }
            let menu = Menu(categoryID: [0], description: descriptionPosition, image: image, name: name, cost: cost)
            realmService?.addPositionInBasket(menuInfo: menu, countPosition: resultsBasket.countPosition - 1)
        }
    }
    
    func plusButtonTapped(indexPath: IndexPath) {
        guard let resultsBasket = resultsBasket?[indexPath.row],
              let descriptionPosition = resultsBasket.descriptionPosition,
              let image = resultsBasket.image,
              let name = resultsBasket.name,
              let cost = resultsBasket.cost else { return }
        let menu = Menu(categoryID: [0], description: descriptionPosition, image: image, name: name, cost: cost)
        realmService?.addPositionInBasket(menuInfo: menu, countPosition: resultsBasket.countPosition + 1)
        realmService?.realmUrl()
    }
    
    func loadMenuImageToCache() {
        let group = DispatchGroup()
        guard let resultsBasket else { return }
        for info in resultsBasket {
            group.enter()
            guard let imageBasket = info.image else { return }
            if imageCache.object(forKey: imageBasket as NSString) == nil {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    guard let self else { return }
                    let image = imageBasket.image
                    self.imageCache.setObject(image, forKey: imageBasket as NSString)
                    group.leave()
                }
            } else {
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            self.view?.reloadVC(totalSum: self.totalSum)
            print("Позиции загрузились в кэш КОРЗИНЫ")
        }
    }
}
