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
