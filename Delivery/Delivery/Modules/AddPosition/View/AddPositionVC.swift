//
//  AddPosition.swift
//  Delivery
//
//  Created by Artsiom Korenko on 26.11.22.
//

import Foundation
import UIKit
import SnapKit

protocol AddPositionVCProtocol {
    func configureVC(menuInfo: Menu, image: UIImage)
    func changeCountLabel(value: Int, cost: Int)
    // This metod change off/on status button plus and minus
    func changeStatusButton(isMinusButton: Bool, isPlusButton: Bool)
}

class AddPositionVC: BaseVC, AddPositionVCProtocol {
    
    var presenter: AddPositionPresenterProtocol!
    
    private lazy var tapGestureToCloseVC: UITapGestureRecognizer = {
        var gesture = UITapGestureRecognizer(target: self, action: #selector(tapOnBlurView))
        return gesture
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        var blur = UIBlurEffect(style: UIBlurEffect.Style.light)
        var view = UIVisualEffectView(effect: blur)
        return view
    }()
    
    private lazy var menuImage: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var mainView: UIView = {
        var view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        return view 
    }()
    
    private lazy var addButton: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = .systemPink
        button.setTitle("Add to basket", for: .normal)
        button.addTarget(self, action: #selector(addMenuPosition), for: .touchUpInside)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemPink
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(plusButtonTap), for: .touchUpInside)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemPink
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.addTarget(self, action: #selector(minusButtonTap), for: .touchUpInside)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var namePositionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()
    
    private lazy var costLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        var label = UILabel()
        label.tintColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "21"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        addElements()
        updateViewConstraints()
    }
    
    func configureVC(menuInfo: Menu, image: UIImage) {
        guard let cost = menuInfo.cost else { return }
        menuImage.image = image
        namePositionLabel.text = menuInfo.name
        costLabel.text =  "Cost: \(cost.description) $"
        descriptionLabel.text = menuInfo.description
    }
    
    @objc func plusButtonTap(sender: UIButton) {
        presenter.plusPosition()
    }
    
    @objc func minusButtonTap(sender: UIButton) {
        presenter.minusPosition()
    }
    
    @objc func addMenuPosition(sender: UIButton) {
        presenter.addPositionInBasket()
        presenter.closeVC(viewController: self)
    }
    
    @objc func closeButtonTapped(sender: UIButton) {
        presenter.closeVC(viewController: self)
    }
    
    @objc func tapOnBlurView(_ sender: UITapGestureRecognizer) {
        presenter.closeVC(viewController: self)
    }
    
    func changeStatusButton(isMinusButton: Bool, isPlusButton: Bool) {
        minusButton.isEnabled = isMinusButton
        plusButton.isEnabled = isPlusButton
    }
    
    func changeCountLabel(value: Int, cost: Int) {
        countLabel.text = value.description
        costLabel.text =  "Cost: \(cost.description) $"
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        blurView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        minusButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
            $0.width.height.equalTo(40)
        }
                
        plusButton.snp.makeConstraints {
            $0.leading.equalTo(minusButton.snp.trailing).offset(40)
            $0.bottom.equalToSuperview().inset(24)
            $0.width.height.equalTo(40)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalTo(minusButton.snp.centerY)
            $0.leading.equalTo(minusButton.snp.trailing)
            $0.trailing.equalTo(plusButton.snp.leading)
        }
                
        addButton.snp.makeConstraints {
            $0.leading.equalTo(plusButton.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(40)
        }
        
        costLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(addButton.snp.top).offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(costLabel.snp.top).offset(-16)
        }
        
        namePositionLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-16)
        }
        
        menuImage.snp.makeConstraints {
            $0.centerX.equalTo(mainView.snp.centerX)
            $0.width.height.equalTo(view.frame.width * 0.4)
            $0.top.equalTo(mainView.snp.top).offset(8)
            $0.bottom.equalTo(namePositionLabel.snp.top).offset(-8)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(mainView.snp.top).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(40)
        }
        
        mainView.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview()
            $0.top.equalTo(closeButton.snp.top).offset(-16)
        }
    }
    
    private func addElements() {
        view.addSubview(blurView)
        blurView.addGestureRecognizer(tapGestureToCloseVC)
        view.addSubview(mainView)
        view.addSubview(addButton)
        view.addSubview(minusButton)
        view.addSubview(plusButton)
        view.addSubview(countLabel)
        view.addSubview(costLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(namePositionLabel)
        view.addSubview(menuImage)
        view.addSubview(closeButton)
    }
}
