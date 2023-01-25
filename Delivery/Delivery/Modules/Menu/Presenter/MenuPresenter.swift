//
//  MenuPresenter.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

protocol MenuPresenterProtocol: AnyObject {
    func getMenuInfo()
    func getAmountMenuPositions() -> Int
    func configureCellForPositionMenu(indexPath: IndexPath, cell: CellForMenuPositionProtocol) 
    func configureBannerCell(indexPath: IndexPath, cell: CellForBannersProtocol)
    func getMenuInfoInPosition(indexPath: IndexPath)
    func getCellLimit() -> Int
    func loadMenuImageToCache()
    func changeCellRange()
    func showLoader() -> Bool
    func showSlideMenu(tabBarController: UITabBarController)
    func scrollCellByCategories(indexCategory: Int)
}

class MenuPresenter: MenuPresenterProtocol {

    private(set) var imageCache = NSCache<NSString, UIImage>()
    private(set) var banners: [UIImage] = []
    private(set) var view: MenuVCProtocol?
    private(set) var router: MenuRouterProtocol?
    private(set) var menuInfo: [Menu] = []
    private(set) var bannersUrl: Banner?
    private(set) var alamofireProvider: AlamofireProtocol?
    private(set) var realmService: RealmServiceProtocol?
    private(set) var cellLimitRange = 0...4
    private(set) var cellLimit = 5
    private(set) var isShowLoader = true
    
    required init(view: MenuVCProtocol, router: MenuRouterProtocol, alamofireProvider: AlamofireProtocol, realmService: RealmServiceProtocol) {
        self.view = view
        self.router = router
        self.alamofireProvider = alamofireProvider
        self.realmService = realmService
        getMenuInfo()
        getBanners()
    }
    
    func scrollCellByCategories(indexCategory: Int) {
        var value: Int = 0
        switch indexCategory {
        case 0:
            value = 0
        case 1:
            value = 8
        case 2:
            value = 16
        case 3:
            value = 24
        case 4:
            value = 32
        case 5:
            value = 40
        case 6:
            value = 48
        default:
            break
        }
        
        view?.scrollMenuCell(indexCategory: value)
    }
    
    // Get cell limit for MenuVC 
    func getCellLimit() -> Int {
        cellLimit
    }
    
    func showLoader() -> Bool {
        isShowLoader
    }
    
    
    // Change cellRange
    func changeCellRange() {
        guard let first = cellLimitRange.first, let last = cellLimitRange.last else { return }
        cellLimitRange = (first + cellLimit)...(last + cellLimit)
        getMenuInfo()
    }
    
    // Get menu on the firebase
    func getMenuInfo() {
        let group = DispatchGroup()
        for index in cellLimitRange {
            group.enter()
            guard let alamofireProvider = alamofireProvider else { return }
            alamofireProvider.getMenu(position: index) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let success):
                    self.menuInfo.append(success)
                    group.leave()
                case .failure:
                    self.isShowLoader = false
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            self.loadMenuImageToCache()
            print("Пришли позиции меню")
        }
    }
    
    // Load menu image on the cache
    func loadMenuImageToCache() {
        let group = DispatchGroup()
        for info in menuInfo {
            group.enter()
            if imageCache.object(forKey: info.image as NSString) == nil {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    guard let self else { return }
                    let image = info.image.image
                    self.imageCache.setObject(image, forKey: info.image as NSString)
                    group.leave()
                }
            } else {
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            if self.isShowLoader {
                self.changeCellRange()
            }
            self.view?.reloadTableView()
            print("Позиции загрузились в кэш")
        }
    }


    //Get banner on the firebase
    func getBanners() {
        alamofireProvider?.getBanner(completion: { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.bannersUrl = success
                    self.loadBannersImage()
                    print("Пришли банеры")
                case .failure:
                    print("Не пришли банеры")
                }
            }
        })
    }
    
    // Load banners Image
    
    func loadBannersImage() {
        let group = DispatchGroup()
        var banner: [UIImage] = []
        guard let bannersUrl = bannersUrl else { return }
        for url in bannersUrl.baners {
            group.enter()
            DispatchQueue.global(qos: .userInitiated).async {
                banner.append(url.image)
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            self.banners = banner
            self.view?.reloadTableView()
            print("Баннеры загрузились в кэш")
        }
    }
    
    // Get quantity position menu for value cell
    func getAmountMenuPositions() -> Int {
        menuInfo.count
    }
    
    // Metod for configure CellForMenuPosition
    func configureCellForPositionMenu(indexPath: IndexPath, cell: CellForMenuPositionProtocol) {
        guard let image = imageCache.object(forKey: menuInfo[indexPath.row].image as NSString) else { return }
        cell.configureMenuCell(menuInfo: menuInfo[indexPath.row], image: image)
    }
    
    // Metod for configure CellForBanners
    func configureBannerCell(indexPath: IndexPath, cell: CellForBannersProtocol) {
        cell.configureCellForBanner(bannersArray: banners)
    }
    
    // Metod for get menu info and image for open AddPositionVC
    func getMenuInfoInPosition(indexPath: IndexPath) {
        guard let image = imageCache.object(forKey: menuInfo[indexPath.row].image as NSString),
              let router else { return }
        router.showAddPositionVC(menuInfo: menuInfo[indexPath.row], image: image)
    }
    
    func showSlideMenu(tabBarController: UITabBarController) {
        guard let router else { return }
        router.showSlideMenuVC(tabBarController: tabBarController)
    }
}
