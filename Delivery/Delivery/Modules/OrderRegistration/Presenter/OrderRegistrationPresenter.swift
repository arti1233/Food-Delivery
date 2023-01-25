import Foundation
import UIKit

protocol OrderRegistrationPresenterProtocol {
    
}

class OrderRegistrationPresenter: OrderRegistrationPresenterProtocol {
    
    private(set) var view: OrderRegistrationVCProtocol?
    private(set) var router: OrderRegistrationRouterProtocol?
    
    required init(view: OrderRegistrationVCProtocol, router: OrderRegistrationRouterProtocol) {
        self.view = view
        self.router = router
    }
}
