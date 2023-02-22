import Foundation

protocol AddUserInfoPresenterProtocol {
    func addUserInfo(phoneNumber: String, name: String, lastName: String, userAddress: String, flat: Int, floor: Int, entrance: Int)
    
}

class AddUserInfoPresenter: AddUserInfoPresenterProtocol {
    
    private(set) var view: AddUserInfoVCProtocol?
    private(set) var router: AddUserInfoRouterProtocol?
    private(set) var userInfo = UserInfo()
    
    
    required init(view: AddUserInfoVCProtocol, router: AddUserInfoRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func addUserInfo(phoneNumber: String, name: String, lastName: String, userAddress: String, flat: Int, floor: Int, entrance: Int) {
        userInfo.phoneNumber = phoneNumber
        userInfo.name = name
        userInfo.lastName = lastName
        userInfo.userAddress = userAddress
        userInfo.flat = flat
        userInfo.floor = floor
        userInfo.entrance = entrance
    }
    
    
}
