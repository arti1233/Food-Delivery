//
//  UISegmentController+Extension.swift
//  Delivery
//
//  Created by Artsiom Korenko on 22.03.23.
//

import Foundation
import UIKit

class BasicSegmentController: UISegmentedControl {
    
    override init(items: [Any]?) {
        super.init(items: items)
        selectedSegmentIndex = 0
        selectedSegmentTintColor = .basicButtonColor
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
