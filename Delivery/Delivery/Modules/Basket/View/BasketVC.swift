//
//  BasketVC.swift
//  Delivery
//
//  Created by Artsiom Korenko on 17.10.22.
//

import Foundation
import UIKit
import SnapKit

protocol BasketVCProtocol: AnyObject {
    func reloadTableView() 
}

class BasketVC: BaseVC, BasketVCProtocol {
    
    private lazy var emptyBasketLabel: UILabel = {
        var label = UILabel()
        label.text = "Basket is empty!"
        label.textAlignment = .center
        label.numberOfLines = 0 
        return label
    }()
    
    private lazy var transitionToMenuLabel: UILabel = {
        var label = UILabel()
        label.text = "Open the menu and add what you like"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var menuButton: UIButton = {
        var button = UIButton()
        button.setTitle("Go to menu", for: .normal)
        button.addTarget(self, action: #selector(goToMenu), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.tintColor = .white
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var segmentController: UISegmentedControl = {
        var segmentController = UISegmentedControl(items: ["Delivery", "Pickup"])
        segmentController.selectedSegmentIndex = 0
        segmentController.selectedSegmentTintColor = UIColor.systemPink
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        segmentController.addTarget(self, action: #selector(changeView(_:)), for: .valueChanged)
        return segmentController
    }()
    
    private lazy var nextButton: UIButton = {
        var button = UIButton()
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(nextToDelivery), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.tintColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        tableView.register(CellFopBasketPosition.self, forCellReuseIdentifier: CellFopBasketPosition.key)
        return tableView
    }()
    
    
    var presenter: BasketPresenterProtocol? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emptyBasketLabel)
        view.addSubview(transitionToMenuLabel)
        view.addSubview(menuButton)
        view.addSubview(segmentController)
        view.addSubview(nextButton)
        view.addSubview(tableView)
        hideEmptyElement(true)
        title = "Basket"
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         navigationController?.navigationBar.shouldRemoveShadow(true)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        emptyBasketLabel.snp.makeConstraints {
            $0.width.equalTo(view.frame.width * 0.6)
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
        }
        
        transitionToMenuLabel.snp.makeConstraints {
            $0.width.equalTo(view.frame.width * 0.6)
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(emptyBasketLabel.snp.bottom).offset(8)
        }
        
        menuButton.snp.makeConstraints {
            $0.width.equalTo(view.frame.width * 0.6)
            $0.height.equalTo(32)
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(transitionToMenuLabel.snp.bottom).offset(16)
        }
        
        segmentController.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.height.equalTo(40)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(40)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(segmentController.snp.bottom).offset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func changeView(_ sender: UISegmentedControl) {
        
    }
    
    @objc private func nextToDelivery(sender: UIButton) {
        
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    @objc private func goToMenu(sender: UIButton) {
        guard let tabBarController else { return }
        tabBarController.selectedIndex = 0
    }
    
    private func hideEmptyElement(_ isHidden: Bool) {
        emptyBasketLabel.isHidden = isHidden
        transitionToMenuLabel.isHidden = isHidden
        menuButton.isHidden = isHidden
    }
}


extension BasketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter else { return 0 }
        return presenter.getCountPosition()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter,
              let cell = tableView.dequeueReusableCell(withIdentifier: CellFopBasketPosition.key) as? CellFopBasketPosition else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.updateConstraints()
        cell.prepareForReuse()
        cell.closureForMinusButton = {
            
        }
        cell.closureForPlusButton = {
            
        }
        presenter.configurePositionCell(indexPath: indexPath, cell: cell)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter else { return }
        presenter.getMenuInfoInPosition(indexPath: indexPath)
    }
}
