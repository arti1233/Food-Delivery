//
//  ViewController.swift
//  Delivery
//
//  Created by Artsiom Korenko on 16.10.22.
//

import UIKit
import SnapKit

protocol MenuVCProtocol: AnyObject {
    
}

class MenuVC: UIViewController, MenuVCProtocol {
    
    var alamofire: AlamofireProtocol?
    
    private lazy var mainTableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        tableView.register(CellForBanners.self, forCellReuseIdentifier: CellForBanners.key)
        tableView.register(CellForMenuPosition.self, forCellReuseIdentifier: CellForMenuPosition.key)
        return tableView
    }()
    
    
    var presenter: MenuPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellForBanners = tableView.dequeueReusableCell(withIdentifier: CellForBanners.key) as? CellForBanners,
              let cellForPosition = tableView.dequeueReusableCell(withIdentifier: CellForMenuPosition.key) as? CellForMenuPosition else { return UITableViewCell() }
        cellForBanners.updateConstraints()
        cellForPosition.updateConstraints()
        if indexPath.section == 0 {
            return cellForBanners
        } else {
            return cellForPosition
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderViewForСategories()
        
        return section == 1 ? view : UIView() 
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 80 : 0
    }
}

