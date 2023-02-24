import Foundation
import UIKit
import SnapKit

protocol AddUserInfoVCProtocol {
    
}

class AddUserInfoVC: BaseVC, AddUserInfoVCProtocol {
    
    var presenter: AddUserInfoPresenterProtocol?
    
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
        guard let presenter = presenter,
              let name = nameTextField.text,
              let lastName = lastNameTextField.text,
              let phoneNumber = phoneNumberTextField.text,
              let address = addressTextField.text,
              let flat = Int(flatTextField.text!),
              let floor = Int(floorTextField.text!),
              let entrance = Int(entranceTextField.text!) else { return }
        
        presenter.addUserInfo(phoneNumber: phoneNumber, name: name, lastName: lastName, userAddress: address, flat: flat, floor: floor, entrance: entrance)
        dismiss(animated: true)
    }
    
    private func animateEmptyTextField(textField: UITextField) {
        textField.layer.borderColor = UIColor.systemPink.cgColor
        
        UIView.animate(withDuration: 0.2) {
            textField.layer.borderWidth = 2
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.1) {
            textField.layer.borderWidth = 0
        }
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
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case nameTextField:
            return limitCharacterAndLength(characters: .letters, textField: textField, range: range, string: string, maxLength: 10)
        case lastNameTextField:
            return limitCharacterAndLength(characters: .letters, textField: textField, range: range, string: string, maxLength: 10)
        case phoneNumberTextField:
            guard let text = phoneNumberTextField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            phoneNumberTextField.text = phoneFormatter(mask: "+XXX (XX) XXX-XX-XX", phoneNumber: newString)
            return false
        case addressTextField:
            return limitCharacterAndLength(characters: .letters, textField: textField, range: range, string: string, maxLength: 10)
        case flatTextField:
            return limitCharacterAndLength(characters: .decimalDigits, textField: textField, range: range, string: string, maxLength: 3)
        case floorTextField:
            return limitCharacterAndLength(characters: .decimalDigits, textField: textField, range: range, string: string, maxLength: 3)
        case entranceTextField:
            return limitCharacterAndLength(characters: .decimalDigits, textField: textField, range: range, string: string, maxLength: 3)
        default:
            return true
        }
    }
    
    private func limitCharacterAndLength(characters: CharacterSet, textField: UITextField, range: NSRange, string: String, maxLength: Int) -> Bool {
        guard characters.isSuperset(of: CharacterSet(charactersIn: string)),
              let currentText = textField.text,
              let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= maxLength
    }
    
    private func textFieldIsEmpty(textField: UITextField) -> Bool {
        guard let text = textField.text, text.isEmpty else { return false }
        animateEmptyTextField(textField: textField)
        return true
    }
    
    private func phoneFormatter(mask: String, phoneNumber: String) -> String {
        let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result: String = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
    
    private func changeEditingTextField(previousTextField: UITextField, nextTextField: UITextField) {
        guard textFieldIsEmpty(textField: previousTextField) else {
            nextTextField.becomeFirstResponder()
            return
        }
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            changeEditingTextField(previousTextField: nameTextField, nextTextField: lastNameTextField)
        case lastNameTextField:
            changeEditingTextField(previousTextField: lastNameTextField, nextTextField: phoneNumberTextField)
        case phoneNumberTextField:
            changeEditingTextField(previousTextField: phoneNumberTextField, nextTextField: addressTextField)
        case addressTextField:
            changeEditingTextField(previousTextField: addressTextField, nextTextField: flatTextField)
        case flatTextField:
            changeEditingTextField(previousTextField: flatTextField, nextTextField: floorTextField)
        case floorTextField:
            changeEditingTextField(previousTextField: floorTextField, nextTextField: entranceTextField)
        default:
            guard textFieldIsEmpty(textField: entranceTextField) else {
                entranceTextField.resignFirstResponder()
                return
            }
        }
    }
}
