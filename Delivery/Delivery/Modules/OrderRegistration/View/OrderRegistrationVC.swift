//
//  OrderRegistrationVC.swift
//  Delivery
//
//  Created by Artsiom Korenko on 7.12.22.
//

import Foundation
import UIKit
import SnapKit

protocol OrderRegistrationVCProtocol {
    
}

class OrderRegistrationVC: UIViewController, OrderRegistrationVCProtocol {
    
    var presenter: OrderRegistrationPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
    }
    
}
