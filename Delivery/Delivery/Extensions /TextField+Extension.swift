//
//  TextField+Extension.swift
//  Delivery
//
//  Created by Artsiom Korenko on 8.12.22.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        textColor = .systemPink
        backgroundColor = .white
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
