import Foundation
import UIKit
import SnapKit

protocol ProfileVCProtocol: AnyObject {
    func reloadTableView()
    func changeVisibleTableView(isUserLogIn: Bool)
}

enum SectionForProfileVC: Int, CaseIterable {
    case profileInfo = 0
    case previousOrder
}

class ProfileVC: BaseVC, ProfileVCProtocol, CellForUserInfoProtocol {

    var presenter: ProfilePresenterProtocol?
    var userInfo: UserInfo? 
    
    private lazy var notLogInLabel: UILabel = {
        var label = UILabel()
        label.text = "Please log in!"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var logInButton: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 16
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        return button
    }()
    
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
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        tableView.register(CellForUserInfo.self, forCellReuseIdentifier: CellForUserInfo.key)
        tableView.register(CellForPreviousOrder.self, forCellReuseIdentifier: CellForPreviousOrder.key)
        return tableView
    }()
    
    private lazy var allertView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: slideMenuButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pencilButton)
        title = "Profile"
        view.addSubview(notLogInLabel)
        view.addSubview(logInButton)
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigationController else { return }
        navigationController.navigationBar.shouldRemoveShadow(true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func changeVisibleTableView(isUserLogIn: Bool) {
        tableView.isHidden = isUserLogIn
        pencilButton.isHidden = isUserLogIn
    }
    
    @objc private func slideMenuButtonPressed(sender: UIButton) {
        guard let tabBarController,
              let presenter else { return }
        presenter.showSlideMenu(tabBarController: tabBarController)
    }
    
    @objc private func addInfoInProfile(sender: UIButton) {
        guard let presenter else { return }
        presenter.showAddUserInfoVC()
    }
    
    @objc private func logInButtonTapped(sender: UIButton) {
        guard let presenter else { return }
        presenter.showAddUserInfoVC()
    }
    
    func addPhotoButtonTapped() {
 
    }
    
    func logOutButtonTapped() {
        guard let presenter else { return }
        presenter.logOutButtonTapped()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        logInButton.snp.makeConstraints {
            $0.width.equalTo(view.frame.width / 2)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        notLogInLabel.snp.makeConstraints {
            $0.bottom.equalTo(logInButton.snp_topMargin).inset(-24)
            $0.width.equalTo(view.frame.width / 2)
            $0.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        SectionForProfileVC.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellCount = presenter?.getCountCellForOrder() else { return 0 }
        switch SectionForProfileVC.allCases[section] {
        case .profileInfo:
            return 1
        case .previousOrder:
            return cellCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellForUserInfo = tableView.dequeueReusableCell(withIdentifier: CellForUserInfo.key) as? CellForUserInfo,
              let cellForPreviousOrder = tableView.dequeueReusableCell(withIdentifier: CellForPreviousOrder.key) as? CellForPreviousOrder else { return UITableViewCell() }
    
        switch SectionForProfileVC.allCases[indexPath.section] {
        case .profileInfo:
            cellForUserInfo.prepareForReuse()
            cellForUserInfo.backgroundColor = .clear
            cellForUserInfo.selectionStyle = .none
            cellForUserInfo.delegate = self
            cellForUserInfo.updateConstraints()
            presenter?.configureCellForUserInfo(indexPath: indexPath, cell: cellForUserInfo)
            return cellForUserInfo
        case .previousOrder:
            cellForPreviousOrder.prepareForReuse()
            cellForPreviousOrder.updateConstraints()
            cellForPreviousOrder.selectionStyle = .none
            cellForPreviousOrder.backgroundColor = .clear
            presenter?.configureCellForPreviousOrder(indexPath: indexPath, cell: cellForPreviousOrder)
            return cellForPreviousOrder
        }
    }
}
