import Foundation
import RealmSwift

protocol AddUserInfoPresenterProtocol {
    func addUserInfo(phoneNumber: String, name: String, lastName: String, userAddress: String, flat: Int, floor: Int, entrance: Int)
    
}

class AddUserInfoPresenter: AddUserInfoPresenterProtocol {
    
    private(set) var view: AddUserInfoVCProtocol?
    private(set) var router: AddUserInfoRouterProtocol?
    private(set) var realmService: RealmServiceProtocol?
    
    required init(view: AddUserInfoVCProtocol, router: AddUserInfoRouterProtocol, realmService: RealmServiceProtocol) {
        self.view = view
        self.router = router
        self.realmService = realmService
    }
    
    func addUserInfo(phoneNumber: String, name: String, lastName: String, userAddress: String, flat: Int, floor: Int, entrance: Int) {
        guard let realmService else { return }
        
        let userInfo = UserInfo()
        userInfo.phoneNumber = phoneNumber
        userInfo.name = name
        userInfo.lastName = lastName
        userInfo.userAddress = userAddress
        userInfo.flat = flat
        userInfo.floor = floor
        userInfo.entrance = entrance
        
        realmService.addUserInfoInRealm(userInfo: userInfo)
    }
    
    
}
