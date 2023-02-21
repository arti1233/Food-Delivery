import Foundation
import UIKit

protocol BaseAddUserInfoProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol AddUserInfoRouterProtocol: BaseAddUserInfoProtocol {
    
}

class AddUserInfoRouter: AddUserInfoRouterProtocol {
    var builder: ModuleBuilderProtocol?
    var viewController: UIViewController?
    
    init(builder: ModuleBuilderProtocol, viewController: UIViewController) {
        self.builder = builder
        self.viewController = viewController
    }
}
