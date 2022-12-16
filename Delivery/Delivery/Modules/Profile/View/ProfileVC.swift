//
//  ProfileVC.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: slideMenuButton)
        title = "Profile"
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
}
