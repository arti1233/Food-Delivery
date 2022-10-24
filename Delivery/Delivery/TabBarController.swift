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
        tabBar.tintColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 0.765, green: 0.77, blue: 0.788, alpha: 1)
    }
}
