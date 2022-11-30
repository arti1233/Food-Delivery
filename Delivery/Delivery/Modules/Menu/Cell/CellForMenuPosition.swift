//
//  CellForMenuPosition.swift
//  Delivery
//
//  Created by Artsiom Korenko on 24.10.22.
//

import Foundation
import UIKit
import SnapKit

protocol CellForMenuPositionProtocol {
    func configureMenuCell(menuInfo: Menu, image: UIImage)
}

class CellForMenuPosition: UITableViewCell, CellForMenuPositionProtocol {

    static var key = "CellForMenuPosition"
    
    private lazy var pizzaImage: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var viewForCost: UIView = {
        var view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.layer.cornerRadius = 16 
        view.layer.borderColor = UIColor.systemPink.cgColor
        return view
    }()
    
    private lazy var costLabel: UILabel = {
        var label = UILabel()
        label.textColor = .systemPink
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(pizzaImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(viewForCost)
        viewForCost.addSubview(costLabel)
        contentView.addSubview(descriptionLabel)
        viewForCost.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pizzaImage.image = UIImage()
        nameLabel.text = ""
        descriptionLabel.text = ""
        viewForCost.isHidden = true
        costLabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        pizzaImage.snp.makeConstraints {
            $0.height.equalTo(132)
            $0.width.equalTo(132)
            $0.top.bottom.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(8)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(pizzaImage.snp.trailing).offset(32)
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(16)
        }
                
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(pizzaImage.snp.trailing).offset(32)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        viewForCost.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(87)
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        costLabel.snp.makeConstraints {
            $0.centerX.equalTo(viewForCost.snp.centerX)
            $0.centerY.equalTo(viewForCost.snp.centerY)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func configureMenuCell(menuInfo: Menu, image: UIImage) {
        guard let cost = menuInfo.cost else { return }
        nameLabel.text = menuInfo.name
        descriptionLabel.text = menuInfo.description
        pizzaImage.image = image
        viewForCost.isHidden = false
        costLabel.text = "\(cost) $"
    }
}
