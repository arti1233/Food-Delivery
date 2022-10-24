//
//  CellForBanner.swift
//  Delivery
//
//  Created by Artsiom Korenko on 18.10.22.
//

import Foundation
import UIKit
import SnapKit

class CellForBanner: UICollectionViewCell {
    
    static var key = "CellForBanner"
    
    private lazy var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage(named: "banner")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        addElements()
        addConstreint()
    }
 
    override func updateConstraints() {
        super.updateConstraints()
        addConstreint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        contentView.addSubview(mainView)
        mainView.addSubview(imageView)
    }
    
    func addConstreint() {
        mainView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(112)
            $0.width.equalTo(300)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            imageView.layer.cornerRadius = 20
        }
    }
}
