//
//  CellFopBasketPosition.swift
//  Delivery
//
//  Created by Artsiom Korenko on 24.11.22.
//

import Foundation
import UIKit
import SnapKit

protocol CellFopBasketPositionProtocol {
    func configureCell(menuInfo: Menu, image: UIImage, quantityPosition: Int)
}

class CellFopBasketPosition: UITableViewCell, CellFopBasketPositionProtocol {
    static var key = "CellFopBasketPosition"
    
    private lazy var menuImageView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var stepper: UIStepper = {
        var stepper = UIStepper()
        return stepper
    }()
    
    private lazy var numberPositionsLabel: UILabel = {
        var label = UILabel()
        return label
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
        contentView.addSubview(menuImageView)
        contentView.addSubview(stepper)
        contentView.addSubview(numberPositionsLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(viewForCost)
        viewForCost.addSubview(costLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(menuInfo: Menu, image: UIImage, quantityPosition: Int) {
        guard let cost = menuInfo.cost else { return }
        menuImageView.image = image
        numberPositionsLabel.text = quantityPosition.description
        nameLabel.text = menuInfo.name
        descriptionLabel.text = menuInfo.description
        costLabel.text = "\(cost) $"
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        menuImageView.snp.makeConstraints {
            $0.height.width.equalTo(132)
            $0.top.leading.bottom.equalToSuperview().inset(16)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(menuImageView.snp.trailing).offset(24)
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(menuImageView.snp.trailing).offset(24)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        viewForCost.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(32)
            $0.width.equalTo(87)
        }
        
        costLabel.snp.makeConstraints {
            $0.centerX.equalTo(viewForCost.snp.centerX)
            $0.centerY.equalTo(viewForCost.snp.centerY)
            $0.leading.trailing.equalToSuperview()
        }
        
        stepper.snp.makeConstraints {
            $0.leading.equalTo(menuImageView.snp.trailing).offset(24)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(32)
            $0.width.equalTo(87)
        }
        
        numberPositionsLabel.snp.makeConstraints {
            $0.centerY.equalTo(stepper.snp.centerY)
            $0.leading.equalTo(stepper.snp.trailing).offset(16)
        }
    }
}
