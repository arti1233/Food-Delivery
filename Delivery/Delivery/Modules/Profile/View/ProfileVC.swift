//
//  ProfileVC.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

protocol ProfileVCProtocol: AnyObject {
    
}

class ProfileVC: UIViewController, ProfileVCProtocol {
    
    var presenter: ProfilePresenterProtocol? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}
