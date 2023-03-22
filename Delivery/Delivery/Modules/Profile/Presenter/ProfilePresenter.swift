import Foundation
import UIKit
import RealmSwift

protocol ProfilePresenterProtocol: AnyObject {
    func showSlideMenu(tabBarController: UITabBarController)
    func configureCellForPreviousOrder(indexPath: IndexPath, cell: CellForPreviousOrder)
    func configureCellForUserInfo(indexPath: IndexPath, cell: CellForUserInfo)
    func getCountCellForOrder() -> Int
    func showAddUserInfoVC()
    func logOutButtonTapped()
}

class ProfilePresenter: ProfilePresenterProtocol {
    private(set) var view: ProfileVCProtocol?
    private(set) var router: ProfileRouterProtocol?
    private(set) var realmService: RealmServiceProtocol?
    private(set) var notificationTokenForOrderHistory: NotificationToken?
    private(set) var notificationTokenForLogInUser: NotificationToken?
    private(set) var userInfo: UserInfo?
    
    required init(view: ProfileVCProtocol, router: ProfileRouterProtocol, realmService: RealmServiceProtocol) {
        self.view = view
        self.router = router
        self.realmService = realmService
        userInfo = realmService.getUserInfo()
    
        notificationTokenForOrderHistory = realmService.getOrderHistory().observe { [weak self] (changes: RealmCollectionChange) in
            guard let self else { return }
            switch changes {
            default :
                self.userInfo = realmService.getUserInfo()
                self.view?.reloadTableView()
            }
        }
        
        notificationTokenForLogInUser = realmService.getUserInfoResult().observe { [weak self] (changes: RealmCollectionChange) in
            guard let self else { return }
            switch changes {
                default:
                guard let _ = realmService.getUserInfo() else {
                    view.changeVisibleTableView(isUserLogIn: true)
                    return
                }
                view.changeVisibleTableView(isUserLogIn: false)
                self.userInfo = realmService.getUserInfo()
                self.view?.reloadTableView()
            }
        }
        
    }
    
    func logOutButtonTapped() {
        guard let realmService else { return }
        realmService.deleteUserInfo()
        realmService.deleteOrderHistory()
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
    
    func configureCellForUserInfo(indexPath: IndexPath, cell: CellForUserInfo) {
        guard let userInfo else { return }
        cell.configureCell(userInfo: userInfo)
    }
    
    func getCountCellForOrder() -> Int {
        guard let realmService = realmService else { return Int() }
        return realmService.getOrderHistory().count
    }
}
