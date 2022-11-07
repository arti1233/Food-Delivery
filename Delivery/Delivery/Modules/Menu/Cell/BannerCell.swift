//
//  BannerCell.swift
//  Delivery
//
//  Created by Artsiom Korenko on 21.10.22.
//

import Foundation
import UIKit
import SnapKit

protocol BannerCellProtocol {
    func configureCell(indexPath: IndexPath, cell: BannerCell)
}

class BannerCell: UICollectionViewCell, BannerCellProtocol {
    
    static var key = "BannerCell"
    
    private lazy var imageView: UIImageView = {
        var view = UIImageView()
        view.layoutIfNeeded()
        view.contentMode = .scaleToFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        imageView.snp.makeConstraints {
            $0.trailing.leading.bottom.top.equalToSuperview()
        }
    }
    
    func configureCell(indexPath: IndexPath, cell: BannerCell) {
        
    }
    
    func configureCell(image: UIImage) {
        imageView.image = image
    }
}
