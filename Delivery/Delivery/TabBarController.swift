//
//  TabBarController.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .purple
        tabBar.backgroundColor = .white
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .black
    }
}
