import Foundation
import UIKit
import SnapKit

protocol AddUserInfoVCProtocol {
    
}

class AddUserInfoVC: BaseVC, AddUserInfoVCProtocol {
    
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
        label.textAlignment = .center
        label.text = "User info"
        return label
    }()
    
    private lazy var nameTextField: MyTextField = {
        var textField = MyTextField()
        textField.placeholder = "Your name"
        return textField
    }()
    
    private lazy var lastNameTextField: MyTextField = {
        var textField = MyTextField()
        textField.placeholder = "Last name"
        return textField
    }()
    
    private lazy var phoneNumberTextField: MyTextField = {
        var textField = MyTextField()
        textField.placeholder = "Phone number"
        return textField
    }()
    
    private lazy var addressTextField: MyTextField = {
        var textField = MyTextField()
        textField.placeholder = "Address"
        return textField
    }()
    
    private lazy var flatTextField: MyTextField = {
        var textField = MyTextField()
        textField.placeholder = "Flat"
        return textField
    }()
    
    private lazy var floorTextField: MyTextField = {
        var textField = MyTextField()
        textField.placeholder = "Floor"
        return textField
    }()
    
    private lazy var entranceTextField: MyTextField = {
        var textField = MyTextField()
        textField.placeholder = "Entrance"
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        return button
    }()
    
    private let cornerRadius = CGFloat(15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addElements()
        
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        addressTextField.delegate = self
        flatTextField.delegate = self
        floorTextField.delegate = self
        entranceTextField.delegate = self
    }
    
    private func addElements() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(phoneNumberTextField)
        contentView.addSubview(addressTextField)
        contentView.addSubview(flatTextField)
        contentView.addSubview(floorTextField)
        contentView.addSubview(entranceTextField)
        contentView.addSubview(saveButton)
    }
    
    @objc func saveButtonTapped(sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        let widhtTextField = (view.frame.width - 80) / 3
        let heightTextField = 50
        
        scrollView.snp.makeConstraints {
            $0.trailing.leading.bottom.top.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
            $0.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
        }
        
        nameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.height.equalTo(heightTextField)
            nameTextField.layer.cornerRadius = cornerRadius
        }
        
        lastNameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(nameTextField.snp.bottom).offset(16)
            $0.height.equalTo(heightTextField)
            lastNameTextField.layer.cornerRadius = cornerRadius
        }
        
        phoneNumberTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(lastNameTextField.snp.bottom).offset(16)
            $0.height.equalTo(heightTextField)
            phoneNumberTextField.layer.cornerRadius = cornerRadius
        }
        
        addressTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(16)
            $0.height.equalTo(heightTextField)
            addressTextField.layer.cornerRadius = cornerRadius
        }
        
        flatTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(heightTextField)
            $0.width.equalTo(widhtTextField)
            $0.top.equalTo(addressTextField.snp.bottom).offset(16)
            flatTextField.layer.cornerRadius = cornerRadius
        }
        
        floorTextField.snp.makeConstraints {
            $0.leading.equalTo(flatTextField.snp.trailing).offset(16)
            $0.height.equalTo(heightTextField)
            $0.width.equalTo(widhtTextField)
            $0.top.equalTo(addressTextField.snp.bottom).offset(16)
            floorTextField.layer.cornerRadius = cornerRadius
        }
        
        entranceTextField.snp.makeConstraints {
            $0.leading.equalTo(floorTextField.snp.trailing).offset(16)
            $0.height.equalTo(heightTextField)
            $0.width.equalTo(widhtTextField)
            $0.top.equalTo(addressTextField.snp.bottom).offset(16)
            entranceTextField.layer.cornerRadius = cornerRadius
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(entranceTextField.snp.bottom).offset(16)
            $0.height.equalTo(heightTextField)
            $0.bottom.equalToSuperview().inset(100)
        }
    }
}

extension AddUserInfoVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            addressTextField.becomeFirstResponder()
        case addressTextField:
            flatTextField.becomeFirstResponder()
        case flatTextField:
            floorTextField.becomeFirstResponder()
        case floorTextField:
            entranceTextField.becomeFirstResponder()
        default:
            entranceTextField.becomeFirstResponder()
        }
    }
}
