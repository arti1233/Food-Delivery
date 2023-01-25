import Foundation
import UIKit
import SnapKit

protocol ProfileVCProtocol: AnyObject {
    
}

class ProfileVC: BaseVC, ProfileVCProtocol, CellForUserInfoProtocol {

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
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        tableView.register(CellForUserInfo.self, forCellReuseIdentifier: CellForUserInfo.key)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: slideMenuButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pencilButton)
        title = "Profile"
        view.addSubview(tableView)
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
    
    func addPhotoButtonTapped() {
        print("Не забудь добавить фото!")
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        tableView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellForUserInfo = tableView.dequeueReusableCell(withIdentifier: CellForUserInfo.key) as? CellForUserInfo else { return UITableViewCell() }
        cellForUserInfo.updateConstraints()
        cellForUserInfo.backgroundColor = .clear
        cellForUserInfo.delegate = self
        return cellForUserInfo
    }
}
