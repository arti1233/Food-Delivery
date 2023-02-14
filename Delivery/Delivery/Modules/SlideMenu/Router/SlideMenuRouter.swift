import Foundation
import UIKit

protocol BaseSlideMenuProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol SlideMenuRouterProtocol: BaseSlideMenuProtocol {
    
}

class SlideMenuRouter: SlideMenuRouterProtocol {
    var builder: ModuleBuilderProtocol?
    var viewController: UIViewController?
    
    init( builder: ModuleBuilderProtocol, viewController: UIViewController) {
        self.builder = builder
        self.viewController = viewController
    }
    
}
