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
        floatingLabelActiveTextColor = .basicButtonColor
        floatingLabelTextColor = .basicButtonColor
        floatingLabel.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
