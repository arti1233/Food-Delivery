//
//  OrderRegistrationVC.swift
//  Delivery
//
//  Created by Artsiom Korenko on 7.12.22.
//

import Foundation
import UIKit
import SnapKit
import JVFloatLabeledTextField

protocol OrderRegistrationVCProtocol {
    
}

class OrderRegistrationVC: UIViewController, OrderRegistrationVCProtocol {
    
    var presenter: OrderRegistrationPresenterProtocol!
    
    private lazy var registrationButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(restorationButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        button.setTitle("Сonfirm order", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 25
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        var view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var contentView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Delivery"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var addressTextField: MyTextField = {
        var textField = MyTextField()
        textField.setPlaceholder("Delivery address", floatingTitle: "Delivery address")
        return textField
    }()

    private lazy var flatTextField: MyTextField = {
        var textField = MyTextField()
        textField.setPlaceholder("Flat", floatingTitle: "Flat")
        return textField
    }()
    
    private lazy var entranceTextField: MyTextField = {
        var textField = MyTextField()
        textField.setPlaceholder("Entrance", floatingTitle: "Entrance")
        return textField
    }()
    
    private lazy var floorTextField: MyTextField = {
        var textField = MyTextField()
        textField.setPlaceholder("Floor", floatingTitle: "Floor")
        return textField
    }()
    
    private lazy var nameTextField: MyTextField = {
        var textField = MyTextField()
        textField.setPlaceholder("Your name", floatingTitle: "Your name")
        return textField
    }()
    
    private lazy var phoneNumberTextField: MyTextField = {
        var textField = MyTextField()
        textField.setPlaceholder("Phone number", floatingTitle: "Phone number")
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        addElementsOnView()
    }
    
//MARK: Actions
    @objc private func restorationButtonTapped(sender: UIButton) {
        
    }
    
//MARK: Metods
    
    private func addElementsOnView() {
        view.addSubview(registrationButton)
        view.addSubview(scrollView)
        view.addSubview(titleLabel)
        scrollView.addSubview(contentView)
        contentView.addSubview(addressTextField)
        contentView.addSubview(flatTextField)
        contentView.addSubview(entranceTextField)
        contentView.addSubview(floorTextField)
        contentView.addSubview(nameTextField)
        contentView.addSubview(phoneNumberTextField)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        registrationButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(32)
            $0.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
        }
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(registrationButton.snp.top).inset(-16)
            $0.top.equalTo(titleLabel.snp_bottomMargin).inset(-16)
        }

        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
            $0.top.bottom.equalToSuperview()
        }
    
        let widhtTextField = (view.frame.width - 64) / 3
        let heightTextField = 50
        let cornerRadius = CGFloat(15)

        addressTextField.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp_bottomMargin).offset(32)
            $0.height.equalTo(heightTextField)
            addressTextField.layer.cornerRadius = cornerRadius
        }

        flatTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(heightTextField)
            $0.width.equalTo(widhtTextField)
            $0.top.equalTo(addressTextField.snp_bottomMargin).offset(32)
            flatTextField.layer.cornerRadius = cornerRadius
        }

        entranceTextField.snp.makeConstraints {
            $0.leading.equalTo(flatTextField.snp.trailing).offset(16)
            $0.height.equalTo(heightTextField)
            $0.width.equalTo(widhtTextField)
            $0.top.equalTo(addressTextField.snp_bottomMargin).offset(32)
            entranceTextField.layer.cornerRadius = cornerRadius
        }

        floorTextField.snp.makeConstraints {
            $0.leading.equalTo(entranceTextField.snp.trailing).offset(16)
            $0.height.equalTo(heightTextField)
            $0.width.equalTo(widhtTextField)
            $0.top.equalTo(addressTextField.snp_bottomMargin).offset(32)
            floorTextField.layer.cornerRadius = cornerRadius
        }

        nameTextField.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(flatTextField.snp_bottomMargin).offset(32)
            $0.height.equalTo(heightTextField)
            nameTextField.layer.cornerRadius = cornerRadius
        }

        phoneNumberTextField.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview().inset(16)
            $0.top.equalTo(nameTextField.snp_bottomMargin).offset(32)
            $0.height.equalTo(heightTextField)
            phoneNumberTextField.layer.cornerRadius = cornerRadius
        }
    }
}


