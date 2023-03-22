import Foundation
import RealmSwift

protocol AddUserInfoPresenterProtocol {
    func addUserInfo(phoneNumber: String, name: String, lastName: String, userAddress: String, flat: Int, floor: Int, entrance: Int)
    
}

class AddUserInfoPresenter: AddUserInfoPresenterProtocol {
    
    private(set) var view: AddUserInfoVCProtocol?
    private(set) var router: AddUserInfoRouterProtocol?
    private(set) var realmService: RealmServiceProtocol?
    private(set) var userInfo: UserInfo?
    
    required init(view: AddUserInfoVCProtocol, router: AddUserInfoRouterProtocol, realmService: RealmServiceProtocol, userInfo: UserInfo?) {
        self.view = view
        self.router = router
        self.realmService = realmService
        self.userInfo = userInfo
        autoFillTextField(userInfo: userInfo)
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
        
        realmService.addUserInfoInRealm(newUserInfo: userInfo)
    }
    
    private func autoFillTextField(userInfo: UserInfo?) {
        guard let userInfo, let view else { return }
        view.fillTextField(userInfo: userInfo)
    }
}
