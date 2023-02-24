import Foundation
import UIKit
import RealmSwift

protocol ProfilePresenterProtocol: AnyObject {
    func showSlideMenu(tabBarController: UITabBarController)
    func configureCellForPreviousOrder(indexPath: IndexPath, cell: CellForPreviousOrder)
    func getCountCellForOrder() -> Int
    func showAddUserInfoVC()
}

class ProfilePresenter: ProfilePresenterProtocol {
    private(set) var view: ProfileVCProtocol?
    private(set) var router: ProfileRouterProtocol?
    private(set) var realmService: RealmServiceProtocol?
    private(set) var notificationToken: NotificationToken?
    
    required init(view: ProfileVCProtocol, router: ProfileRouterProtocol, realmService: RealmServiceProtocol) {
        self.view = view
        self.router = router
        self.realmService = realmService
        
        notificationToken = realmService.getOrderHistory().observe { [weak self] (changes: RealmCollectionChange) in
            guard let self else { return }
            switch changes {
            default :
                self.view?.reloadTableView()
            }
        }
    }
    
    func showAddUserInfoVC() {
        guard let router else { return }
        router.showAddUserInfoVC()
    }
    
    func showSlideMenu(tabBarController: UITabBarController) {
        guard let router else { return }
        router.showSlideMenuVC(tabBarController: tabBarController)
    }
    
    func configureCellForPreviousOrder(indexPath: IndexPath, cell: CellForPreviousOrder) {
        guard let realmService = realmService else { return }
        cell.configureCell(order: realmService.getOrderHistory()[indexPath.row])
    }
    
    func getCountCellForOrder() -> Int {
        guard let realmService = realmService else { return Int() }
        return realmService.getOrderHistory().count
    }
}
