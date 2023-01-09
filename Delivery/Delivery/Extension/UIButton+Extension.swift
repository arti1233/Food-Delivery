//
//  UIButton+Extension.swift
//  Delivery
//
//  Created by Artsiom Korenko on 15.12.22.
//

import Foundation
import UIKit

class SlideMenuButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        semanticContentAttribute = .forceLeftToRight
        tintColor = .systemPink
        contentHorizontalAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
