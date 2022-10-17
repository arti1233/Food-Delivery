//
//  BasketVC.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

protocol BasketVCProtocol: AnyObject {
    
}

class BasketVC: UIViewController, BasketVCProtocol {
    
    var presenter: BasketPresenterProtocol? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
}
