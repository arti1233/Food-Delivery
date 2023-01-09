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
        textField.placeholder = "Delivery address"
        return textField
    }()

    private lazy var flatTextField: MyTextField = {
        var textField = MyTextField()
        textField.placeholder = "Flat"
        return textField
    }()
    
    private lazy var entranceTextField: MyTextField = {
        var textField = MyTextField()
        textField.placeholder = "Entrance"
        return textField
    }()
    
    private lazy var floorTextField: MyTextField = {
        var textField = MyTextField()
        textField.placeholder = "Floor"
        return textField
    }()
    
    private lazy var nameTextField: MyTextField = {
        var textField = MyTextField()
        textField.placeholder = "Your name"
        return textField
    }()
    
    private lazy var phoneNumberTextField: MyTextField = {
        var textField = MyTextField()
        textField.placeholder = "Phone number"
        return textField
    }()
    
    private lazy var delevirySegmentController: UISegmentedControl = {
        var segmentController = UISegmentedControl(items: ["Quickly as possible", "Pre-order"])
        segmentController.selectedSegmentIndex = 0
        segmentController.selectedSegmentTintColor = UIColor.systemPink
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        segmentController.addTarget(self, action: #selector(changePaymentMethod(_:)), for: .valueChanged)
        return segmentController
    }()
    
    private lazy var paymentSegmentController: UISegmentedControl = {
        var segmentController = UISegmentedControl(items: ["Cash", "Сard", "Online"])
        segmentController.selectedSegmentIndex = 0
        segmentController.selectedSegmentTintColor = UIColor.systemPink
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        segmentController.addTarget(self, action: #selector(changePaymentMethod(_:)), for: .valueChanged)
        return segmentController
    }()
    
    private lazy var textViewForComment: JVFloatLabeledTextView = {
        var view = JVFloatLabeledTextView()
        view.placeholder = "Comment for order"
        view.backgroundColor = .white
        view.floatingLabelXPadding = 16
        view.floatingLabelActiveTextColor = .systemPink
        view.floatingLabelTextColor = .systemPink
        view.floatingLabel.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        view.textContainerInset = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
        return view
    }()
    
    private lazy var viewForRegistrationButton: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private lazy var totalCostLabel: UILabel = {
        var label = UILabel()
        label.text = "Total: 300$"
        return label
    }()
    
    private lazy var registrationButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(restorationButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        button.setTitle("Сonfirm order", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 25
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        addElementsOnView()
    }
    
//MARK: Actions
    @objc private func restorationButtonTapped(sender: UIButton) {
        
    }
    
    @objc private func fastDeliveryButtonTapped(sender: UIButton) {
        
    }
    
    @objc private func preOrderButtonTapped(sender: UIButton) {
        
    }
    
    @objc private func changePaymentMethod(_ sender: UISegmentedControl) {
        
    }
    
//MARK: Metods
    private func addElementsOnView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(addressTextField)
        contentView.addSubview(flatTextField)
        contentView.addSubview(entranceTextField)
        contentView.addSubview(floorTextField)
        contentView.addSubview(nameTextField)
        contentView.addSubview(phoneNumberTextField)
        contentView.addSubview(delevirySegmentController)
//        contentView.addSubview(preOrderButton)
        contentView.addSubview(paymentSegmentController)
        contentView.addSubview(textViewForComment)
        view.addSubview(viewForRegistrationButton)
        viewForRegistrationButton.addSubview(totalCostLabel)
        viewForRegistrationButton.addSubview(registrationButton)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        scrollView.snp.makeConstraints {
            $0.leading.bottom.top.trailing.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
            $0.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
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
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(nameTextField.snp_bottomMargin).offset(32)
            $0.height.equalTo(heightTextField)
            phoneNumberTextField.layer.cornerRadius = cornerRadius
        }
        
        delevirySegmentController.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(phoneNumberTextField.snp_bottomMargin).offset(32)
            $0.height.equalTo(40)
            delevirySegmentController.layer.cornerRadius = cornerRadius
        }
        
        paymentSegmentController.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(delevirySegmentController.snp_bottomMargin).offset(32)
            paymentSegmentController.layer.cornerRadius = cornerRadius
        }
        
        viewForRegistrationButton.snp.makeConstraints {
            $0.bottom.trailing.leading.equalToSuperview().inset(-1)
        }
        
        totalCostLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
        
        registrationButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(totalCostLabel.snp_bottomMargin).offset(16)
            $0.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(40)
            registrationButton.layer.cornerRadius = 20
        }
        
        textViewForComment.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(paymentSegmentController.snp_bottomMargin).offset(32)
            $0.height.equalTo(heightTextField * 2)
            $0.bottom.equalToSuperview().inset(150)
            textViewForComment.layer.cornerRadius = cornerRadius
        }
    }
}


