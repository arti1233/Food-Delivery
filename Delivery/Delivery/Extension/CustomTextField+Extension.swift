//
//  TextField+Extension.swift
//  Delivery
//
//  Created by Artsiom Korenko on 5.01.23.
//

import Foundation
import JVFloatLabeledTextField

class MyTextField: JVFloatLabeledTextField {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:16, height:10))
        spacerView.backgroundColor = .clear
        leftViewMode = .always
        leftView = spacerView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
