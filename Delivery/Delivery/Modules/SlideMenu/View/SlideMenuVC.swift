//
//  SlideMenuVC.swift
//  Delivery
//
//  Created by Artsiom Korenko on 14.12.22.
//

import Foundation
import UIKit
import SnapKit

protocol SlideMenuVCProtocol: AnyObject {
    
}

class SlideMenuVC: UIViewController, SlideMenuVCProtocol {
    
    var presenter: SlideMenuPresenterProtocol!
    
    lazy private var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy private var menuButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.semanticContentAttribute = .forceLeftToRight
        button.tintColor = .black
        button.setTitle("   Menu", for: .normal)
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    lazy private var profileButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(profileButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.semanticContentAttribute = .forceLeftToRight
        button.tintColor = .black
        button.setTitle("   Profile", for: .normal)
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    lazy private var basketButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(basketButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.semanticContentAttribute = .forceLeftToRight
        button.tintColor = .black
        button.setTitle("   Basket", for: .normal)
        button.setImage(UIImage(named: "CustomBasket"), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    lazy private var aboutButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(aboutButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.semanticContentAttribute = .forceLeftToRight
        button.tintColor = .black
        button.setTitle(" About us", for: .normal)
        button.setImage(UIImage(systemName: "house"), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    lazy private var reviewButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(reviewButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.semanticContentAttribute = .forceLeftToRight
        button.tintColor = .black
        button.setTitle(" Write review", for: .normal)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(mainView)
        mainView.addSubview(menuButton)
        mainView.addSubview(profileButton)
        mainView.addSubview(basketButton)
        mainView.addSubview(aboutButton)
        mainView.addSubview(reviewButton)
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        mainView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(view.frame.width * 0.6)
        }
        
        menuButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
        }
        
        profileButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(menuButton.snp.bottom).offset(32)
        }
        
        basketButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(profileButton.snp.bottom).offset(32)
        }
        
        aboutButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(basketButton.snp.bottom).offset(32)
        }
        
        reviewButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(aboutButton.snp.bottom).offset(32)
        }
    }
    
//MARK: Button actions
    
    @objc private func menuButtonPressed(sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func profileButtonPressed(sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func basketButtonPressed(sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func aboutButtonPressed(sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func reviewButtonPressed(sender: UIButton) {
        dismiss(animated: true)
    }
}
