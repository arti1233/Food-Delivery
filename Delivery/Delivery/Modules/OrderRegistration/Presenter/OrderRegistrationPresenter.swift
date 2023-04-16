import Foundation
import UIKit
import RealmSwift

protocol OrderRegistrationPresenterProtocol {
    func saveOrderInRealm()
}

class OrderRegistrationPresenter: OrderRegistrationPresenterProtocol {
    
    private(set) var view: OrderRegistrationVCProtocol?
    private(set) var router: OrderRegistrationRouterProtocol?
    private(set) var realmService: RealmServiceProtocol?
    private(set) var resultsBasket: Results<Basket>?
    private(set) var userInfo: UserInfo?
    
    required init(view: OrderRegistrationVCProtocol, router: OrderRegistrationRouterProtocol, realmService: RealmServiceProtocol) {
        self.view = view
        self.router = router
        self.realmService = realmService
        resultsBasket = realmService.getAllPositionInBasket()
        userInfo = realmService.getUserInfo()
        guard let userInfo else { return }
        view.autoFillTextField(userInfo: userInfo)
    }
    
    func saveOrderInRealm() {
        guard let realmService, let view else { return }
        realmService.addBasketInOrderHistory()
        view.dismissOrderRegistrationVC()
    }
}
