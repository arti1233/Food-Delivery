import Foundation
import UIKit
import SnapKit

protocol CellForPreviousOrderProtocol {
    
}

class CellForPreviousOrder: UITableViewCell {
    
    static var key = "CellForPreviousOrder"
    var delegate: CellForPreviousOrderProtocol!
    
   

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func updateConstraints() {
        super.updateConstraints()
       
    }
}

