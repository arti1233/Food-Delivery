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
        view.alpha = 0
        return view
    }()
    
    private lazy var menuImage: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var mainView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = .basicBackgroundColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        return view 
    }()
    
    private lazy var addButton: BasicButton = {
        var button = BasicButton()
        button.setTitle("Add to basket", for: .normal)
        button.addTarget(self, action: #selector(addMenuPosition), for: .touchUpInside)
        return button
    }()
    
    private lazy var plusButton: BasicButton = {
        var button = BasicButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(plusButtonTap), for: .touchUpInside)
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var minusButton: BasicButton = {
        var button = BasicButton()
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.addTarget(self, action: #selector(minusButtonTap), for: .touchUpInside)
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
    
    private lazy var closeButton: BasicButton = {
        var button = BasicButton()
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.8) {
            self.blurView.alpha = 1
        }
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

//MARK: - Actions
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
