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
}

class MenuPresenter: MenuPresenterProtocol {
    
    private(set) var imageCache = NSCache<NSString, UIImage>()
    private(set) var banners: [UIImage] = []
    private(set) var view: MenuVCProtocol?
    private(set) var router: MenuRouterProtocol?
    private(set) var menuInfo: [Menu]?
    private(set) var bannersUrl: Banner?
    private(set) var alamofireProvider: AlamofireProtocol?
    private(set) var pageLimit = 5
    
    required init(view: MenuVCProtocol, router: MenuRouterProtocol, alamofireProvider: AlamofireProtocol) {
        self.view = view
        self.router = router
        self.alamofireProvider = alamofireProvider
        getMenuInfo()
        getBanners()
    }
    
    // Get menu on the firebase
    func getMenuInfo() {
        alamofireProvider?.getMenu(completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.menuInfo = success
                    self.view?.successRequestForMenu()
                    print("Пришло меню")
                case .failure:
                    print("Не пришло меню")
                }
            }
        })
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
        for url in bannersUrl.banner {
            group.enter()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                self.banners.append(url.image)
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.view?.reload()
        }
    }
    
    // Get quantity position menu for value cell
    func getAmountMenuPositions() -> Int {
        guard let menuInfo = menuInfo else { return 0 }
        return menuInfo.count
    }
    
    // Metod for configure CellForMenuPositionProtocol
    func configureCellForPositionMenu(indexPath: IndexPath, cell: CellForMenuPositionProtocol) {
        guard let menuInfo = menuInfo else { return }
        if let cachedImage = imageCache.object(forKey: menuInfo[indexPath.row].image as NSString) {
            cell.configureMenuCell(menuInfo: menuInfo[indexPath.row], image: cachedImage)
        } else {
            cell.startSpinerAnimation()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                let image = menuInfo[indexPath.row].image.image
                self.imageCache.setObject(image, forKey: menuInfo[indexPath.row].image as NSString)
                DispatchQueue.main.async {
                    cell.configureMenuCell(menuInfo: menuInfo[indexPath.row], image: image)
                    cell.stopSpinerAnimation()
                }
            }
        }
    }
    
    func configureBannerCell(indexPath: IndexPath, cell: CellForBannersProtocol) {
        cell.configureCellForBanner(bannersArray: banners)
    }
}
