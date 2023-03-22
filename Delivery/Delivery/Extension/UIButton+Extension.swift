import Foundation
import UIKit

class SlideMenuButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        semanticContentAttribute = .forceLeftToRight
        tintColor = .basicButtonColor
        contentHorizontalAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BasicButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        tintColor = .basicWhiteColor
        backgroundColor = .basicButtonColor
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SlideMenuButtonForNavBar: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tintColor = .black
        setImage(UIImage(systemName: "text.justify"), for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
