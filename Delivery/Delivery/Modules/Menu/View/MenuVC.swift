//
//  ViewController.swift
//  Delivery
//
//  Created by Artsiom Korenko on 16.10.22.
//

import UIKit
import SnapKit

protocol MenuVCProtocol: AnyObject {
    func successRequestForMenu()
    func reload() 
}

class MenuVC: BaseVC, MenuVCProtocol {

    private lazy var mainTableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        tableView.register(CellForBanners.self, forCellReuseIdentifier: CellForBanners.key)
        tableView.register(CellForMenuPosition.self, forCellReuseIdentifier: CellForMenuPosition.key)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.key)
        return tableView
    }()
    
    private lazy var cityChooseButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(cityChoosePressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.semanticContentAttribute = .forceRightToLeft
        button.tintColor = .black
        button.setTitle("City ", for: .normal)
        button.setImage(UIImage(named: "Icon"), for: .normal)
        return button
    }()
    
    var presenter: MenuPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityChooseButton)
        view.addSubview(mainTableView)
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        mainTableView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func successRequestForMenu() {
        mainTableView.tableHeaderView = HeaderViewForСategories()
        mainTableView.reloadData()
    }
    
    func reload() {
        mainTableView.reloadData()
    }
    
    @objc private func cityChoosePressed(sender: UIButton) {
        view.frame.origin.x = view.frame.origin.x + 150
        print("Здоров заебал")
    }
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return presenter.getAmountMenuPositions()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellForBanners = tableView.dequeueReusableCell(withIdentifier: CellForBanners.key) as? CellForBanners,
              let cellForPosition = tableView.dequeueReusableCell(withIdentifier: CellForMenuPosition.key) as? CellForMenuPosition else { return UITableViewCell() }
        cellForBanners.updateConstraints()
        cellForPosition.updateConstraints()
        cellForPosition.prepareForReuse()
        cellForPosition.selectionStyle = .none
        if indexPath.section == 0 {
            presenter.configureBannerCell(indexPath: indexPath, cell: cellForBanners)
            return cellForBanners
        } else {
            presenter.configureCellForPositionMenu(indexPath: indexPath, cell: cellForPosition)
            return cellForPosition
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderViewForСategories()
        return section == 1 ? view : UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 72 : 0
    }
}

