import Foundation
import UIKit
import SnapKit
import JVFloatLabeledTextField

protocol OrderRegistrationVCProtocol {
    
}

class OrderRegistrationVC: UIViewController, OrderRegistrationVCProtocol {
    
    var presenter: OrderRegistrationPresenterProtocol!
    
    //MARK: - Variables 
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
        label.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        label.textColor = .systemPink
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
        segmentController.addTarget(self, action: #selector(changeDeliveryMethod(_:)), for: .valueChanged)
        segmentController.layer.shadowColor = UIColor.black.cgColor
        segmentController.layer.shadowRadius = 5
        segmentController.layer.shadowOpacity = 0.2
        segmentController.layer.shadowOffset = CGSize(width: 5, height: 5)
        return segmentController
    }()
    
    private lazy var randomView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        return view
    }()
    
    private lazy var paymentSegmentController: UISegmentedControl = {
        var segmentController = UISegmentedControl(items: ["Cash", "Сard", "Online"])
        segmentController.selectedSegmentIndex = 0
        segmentController.selectedSegmentTintColor = UIColor.systemPink
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        segmentController.addTarget(self, action: #selector(changePaymentMethod(_:)), for: .valueChanged)
        segmentController.layer.shadowColor = UIColor.black.cgColor
        segmentController.layer.shadowRadius = 5
        segmentController.layer.shadowOpacity = 0.2
        segmentController.layer.shadowOffset = CGSize(width: 5, height: 5)
        return segmentController
    }()
    
    private lazy var shadowView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        return view
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
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
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
    
    //MARK: - Params for elements
    private let heightSegmentController = 40
    private let heightTextField = 50
    private let cornerRadius = CGFloat(15)
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        addElementsOnView()
    }
    
    //MARK: - Actions
    @objc private func restorationButtonTapped(sender: UIButton) {
        
    }
    
    @objc private func fastDeliveryButtonTapped(sender: UIButton) {
        
    }
    
    @objc private func preOrderButtonTapped(sender: UIButton) {
        
    }
    
    @objc private func changePaymentMethod(_ sender: UISegmentedControl) {
        
    }
    
    @objc private func changeDeliveryMethod(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            closeDataPicker()
        case 1:
            showDataPicker()
        default:
            break
        }
    }
    
    //MARK: - Metods for add Elements on View
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
        contentView.addSubview(randomView)
        contentView.addSubview(paymentSegmentController)
        contentView.addSubview(shadowView)
        contentView.addSubview(textViewForComment)
        view.addSubview(viewForRegistrationButton)
        viewForRegistrationButton.addSubview(totalCostLabel)
        viewForRegistrationButton.addSubview(registrationButton)
    }
    
    // MARK: - Metods for constraints
    
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

        addressTextField.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp_bottomMargin).offset(32)
            $0.height.equalTo(heightTextField)
            addressTextField.layer.cornerRadius = cornerRadius
        }
        
        let widhtTextField = (view.frame.width - 64) / 3

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
            $0.height.equalTo(heightSegmentController)
            delevirySegmentController.layer.cornerRadius = cornerRadius
        }
        
        randomView.snp.makeConstraints {
            $0.height.equalTo(0)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(delevirySegmentController.snp_bottomMargin).offset(16)
            randomView.layer.cornerRadius = cornerRadius
        }
        
        paymentSegmentController.snp.makeConstraints {
            $0.height.equalTo(heightSegmentController)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(randomView.snp_bottomMargin).offset(16)
            paymentSegmentController.layer.cornerRadius = cornerRadius
        }
        
        viewForRegistrationButton.snp.makeConstraints {
            $0.bottom.trailing.leading.equalToSuperview()
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
        
        shadowView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(paymentSegmentController.snp_bottomMargin).offset(32)
            $0.height.equalTo(heightTextField * 2)
            $0.bottom.equalToSuperview().inset(150)
            shadowView.layer.cornerRadius = cornerRadius
        }
        
        textViewForComment.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(paymentSegmentController.snp_bottomMargin).offset(32)
            $0.height.equalTo(heightTextField * 2)
            $0.bottom.equalToSuperview().inset(150)
            textViewForComment.layer.cornerRadius = cornerRadius
        }
    }
    
    fileprivate func showDataPicker() {
        randomView.snp.remakeConstraints {
            $0.height.equalTo(heightSegmentController)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(delevirySegmentController.snp_bottomMargin).offset(32)
            randomView.layer.cornerRadius = 15
        }
        
        paymentSegmentController.snp.remakeConstraints {
            $0.height.equalTo(heightSegmentController)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(randomView.snp_bottomMargin).offset(32)
            randomView.layer.cornerRadius = 15
        }
    }
    
    fileprivate func closeDataPicker() {
        randomView.snp.remakeConstraints {
            $0.height.equalTo(0)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(delevirySegmentController.snp_bottomMargin).offset(16)
            randomView.layer.cornerRadius = cornerRadius
        }
        
        paymentSegmentController.snp.remakeConstraints {
            $0.height.equalTo(heightSegmentController)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(randomView.snp_bottomMargin).offset(16)
            paymentSegmentController.layer.cornerRadius = cornerRadius
        }
    }
}


