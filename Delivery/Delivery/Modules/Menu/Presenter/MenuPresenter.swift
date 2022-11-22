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
    func getCellLimit() -> Int
    func loadMenuImageToCache()
    func changeCellRange(indexPath: IndexPath)
    func showLoader() -> Bool
}

class MenuPresenter: MenuPresenterProtocol {
    
    private(set) var imageCache = NSCache<NSString, UIImage>()
    private(set) var banners: [UIImage] = []
    private(set) var view: MenuVCProtocol?
    private(set) var router: MenuRouterProtocol?
    private(set) var menuInfo: [Menu] = []
    private(set) var bannersUrl: Banner?
    private(set) var alamofireProvider: AlamofireProtocol?
    private(set) var cellLimitRange = 0...4
    private(set) var cellLimit = 5
    private(set) var isShowLoader = true
    private(set) var isLoadingMenu = false
    
    required init(view: MenuVCProtocol, router: MenuRouterProtocol, alamofireProvider: AlamofireProtocol) {
        self.view = view
        self.router = router
        self.alamofireProvider = alamofireProvider
        getBanners()
    }
    
    func getCategories(menuInfo: Menu) {
        
    }
    
    // Get cell limit for MenuVC 
    func getCellLimit() -> Int {
        cellLimit
    }
    
    func showLoader() -> Bool {
        isShowLoader
    }
    
    
    // Change cellRange
    func changeCellRange(indexPath: IndexPath) {
        if isLoadingMenu == false {
            guard let first = cellLimitRange.first, let last = cellLimitRange.last else { return }
            cellLimitRange = (first + cellLimit)...(last + cellLimit)
            isLoadingMenu = true
            getMenuInfo()
        }
    }
    
    // Get menu on the firebase
    func getMenuInfo() {
        let group = DispatchGroup()
        for index in cellLimitRange {
            group.enter()
            guard let alamofireProvider = alamofireProvider else { return }
            alamofireProvider.getMenu(position: index) { [weak self] result in
                guard let self = self else { return }
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
            guard let self = self else { return }
            self.loadMenuImageToCache()
            print("Пришли позиции меню")
        }
    }
    
    func loadMenuImageToCache() {
        let group = DispatchGroup()
        for info in menuInfo {
            group.enter()
            if imageCache.object(forKey: info.image as NSString) == nil {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    guard let self = self else { return }
                    let image = info.image.image
                    self.imageCache.setObject(image, forKey: info.image as NSString)
                    group.leave()
                }
            } else {
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.isLoadingMenu = false
            self.view?.reloadTableView()
            print("Позиции загрузились в кэш")
        }
    }


    //Get banner on the firebase
    func getBanners() {
        alamofireProvider?.getBanner(completion: { [weak self] result in
            guard let self = self else { return }
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
        guard let bannersUrl = bannersUrl else { return }
        for url in bannersUrl.baners {
            group.enter()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                self.banners.append(url.image)
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
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
}
