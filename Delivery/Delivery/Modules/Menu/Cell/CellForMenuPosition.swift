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
    func startSpinerAnimation()
    func stopSpinerAnimation()
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
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 4
        return label
    }()
    
    private lazy var viewForCost: UIView = {
        var view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1).cgColor
        return view
    }()
    
    private lazy var costLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.text = "от 345 р"
        return label
    }()
    
    private lazy var spinerView: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = .medium
        view.color = .systemPink
        view.backgroundColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(pizzaImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(viewForCost)
        contentView.addSubview(descriptionLabel)
        viewForCost.addSubview(costLabel)
        contentView.addSubview(spinerView)
        viewForCost.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pizzaImage.image = UIImage()
        nameLabel.text = ""
        descriptionLabel.text = ""
        viewForCost.isHidden = true
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
            $0.leading.equalToSuperview().inset(16)
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
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        
        costLabel.snp.makeConstraints {
            $0.centerX.equalTo(viewForCost.snp.centerX)
            $0.centerY.equalTo(viewForCost.snp.centerY)
            $0.leading.trailing.equalToSuperview()
        }
        
        spinerView.snp.makeConstraints {
            $0.trailing.leading.bottom.top.equalToSuperview()
        }
    }
    
    func configureMenuCell(menuInfo: Menu, image: UIImage) {
        nameLabel.text = menuInfo.name
        descriptionLabel.text = menuInfo.description
        pizzaImage.image = image
        viewForCost.isHidden = false
    }
    
    func startSpinerAnimation() {
        spinerView.startAnimating()
    }
    func stopSpinerAnimation() {
        spinerView.stopAnimating()
    }
}
