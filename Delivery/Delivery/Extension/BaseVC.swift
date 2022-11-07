//
//  BaseVC.swift
//  Delivery
//
//  Created by Artsiom Korenko on 25.10.22.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    
//MARK: Standart setting for UIViewController
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.barTintColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.layoutIfNeeded()
    }
}
