//
//  CellForCategories.swift
//  Delivery
//
//  Created by Artsiom Korenko on 21.10.22.
//

import Foundation
import UIKit
import SnapKit

class CellForCategories: UICollectionViewCell {
    
    static var key = "CellForCategories"
    
    private lazy var category: UIView = {
        var view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemPink.cgColor
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        return view
    }()
    
    private lazy var categoryName: UILabel = {
        var label = UILabel()
        label.text = "Zaebis"
        label.textColor = .systemPink
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(category)
        category.addSubview(categoryName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        category.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(32)
            $0.width.equalTo(88)
        }
        
        categoryName.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.centerX.equalTo(category.snp.centerX)
            $0.centerY.equalTo(category.snp.centerY)
        }
    }
}

