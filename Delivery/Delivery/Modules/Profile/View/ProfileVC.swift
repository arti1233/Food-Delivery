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

class ProfileVC: BaseVC, ProfileVCProtocol {
    
    var presenter: ProfilePresenterProtocol? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigationController else { return }
        navigationController.navigationBar.shouldRemoveShadow(true)
    }
}
