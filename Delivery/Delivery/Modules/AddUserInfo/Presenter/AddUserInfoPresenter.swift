import Foundation

protocol AddUserInfoPresenterProtocol {
    
}

class AddUserInfoPresenter: AddUserInfoPresenterProtocol {
    
    private(set) var view: AddUserInfoVCProtocol?
    private(set) var router: AddUserInfoRouterProtocol?
    
    
    required init(view: AddUserInfoVCProtocol, router: AddUserInfoRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    
}
