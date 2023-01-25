//
//  ProfileVC.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit
import SnapKit

protocol ProfileVCProtocol: AnyObject {
    
}

class ProfileVC: BaseVC, ProfileVCProtocol {
    
    var presenter: ProfilePresenterProtocol?
    
    private lazy var slideMenuButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(slideMenuButtonPressed), for: .touchUpInside)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "text.justify"), for: .normal)
        return button
    }()
    
    private lazy var pencilButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(addInfoInProfile), for: .touchUpInside)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        return button
    }()
    
    private lazy var viewForProfileImage: UIView = {
        var view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.tintColor = .white
        return view
    }()
    
    private lazy var userName: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        label.textAlignment = .center
        label.text = "Artsiom Korenko"
        return label
    }()
    
    private lazy var userPhoneNumberName: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.text = "+375(29) 182-72-84"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: slideMenuButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pencilButton)
        title = "Profile"
        view.addSubview(viewForProfileImage)
        viewForProfileImage.addSubview(profileImage)
        view.addSubview(userName)
        view.addSubview(userPhoneNumberName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigationController else { return }
        navigationController.navigationBar.shouldRemoveShadow(true)
    }
    
    @objc private func slideMenuButtonPressed(sender: UIButton) {
        guard let tabBarController else { return }
        presenter?.showSlideMenu(tabBarController: tabBarController)
    }
    
    @objc private func addInfoInProfile(sender: UIButton) {
        
    }
    
    

    override func updateViewConstraints() {
        super.updateViewConstraints()
        viewForProfileImage.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            $0.centerX.equalTo(view.snp_centerXWithinMargins)
            viewForProfileImage.layer.cornerRadius = 20
            viewForProfileImage.transform = viewForProfileImage.transform.rotated(by: -(.pi / 16))
        }
        
        profileImage.snp.makeConstraints {
            $0.height.width.equalTo(80)
            $0.centerX.equalTo(viewForProfileImage.snp_centerXWithinMargins)
            $0.centerY.equalTo(viewForProfileImage.snp_centerYWithinMargins)
            profileImage.transform = profileImage.transform.rotated(by: .pi / 16)
        }
        
        userName.snp.makeConstraints {
            $0.top.equalTo(viewForProfileImage.snp.bottom).offset(16)
            $0.centerX.equalTo(view.snp_centerXWithinMargins)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        userPhoneNumberName.snp.makeConstraints {
            $0.top.equalTo(userName.snp.bottom).offset(8)
            $0.centerX.equalTo(view.snp_centerXWithinMargins)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
