import UIKit
import SnapKit
import RealmSwift

protocol MenuVCProtocol: AnyObject {
    func reloadTableView()
    func scrollMenuCell(indexCategory: Int)
}

class MenuVC: BaseVC, MenuVCProtocol, HeaderViewForСategoriesProtocol {
    
    private let realm = try! Realm()
    
    enum TableSection: Int, CaseIterable {
        case banners = 0
        case menuPositions
        case loader
    }
    
    private lazy var mainTableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.tableHeaderView = HeaderViewForСategories()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .basicBackgroundColor
        tableView.register(CellForBanners.self, forCellReuseIdentifier: CellForBanners.key)
        tableView.register(CellForMenuPosition.self, forCellReuseIdentifier: CellForMenuPosition.key)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.key)
        tableView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var slideMenuButton: SlideMenuButtonForNavBar = {
        var button = SlideMenuButtonForNavBar(type: .system)
        button.addTarget(self, action: #selector(slideMenuButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var presenter: MenuPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: slideMenuButton)
        view.addSubview(mainTableView)
        print(realm.configuration.fileURL?.description ?? "")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadMainTableView), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.shouldRemoveShadow(true)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        mainTableView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mainTableView.reloadData()
    }

//MARK: - Metods for protocol
    
    func reloadTableView() {
        mainTableView.reloadData()
    }
    
    func scrollMenuCell(indexCategory: Int) {
        mainTableView.scrollToRow(at: IndexPath(item: indexCategory, section: 1), at: .top, animated: true)
    }
    
//MARK: - Actions
    
    @objc private func slideMenuButtonPressed(sender: UIButton) {
        guard let tabBarController else { return }
        presenter.showSlideMenu(tabBarController: tabBarController)
    }
    
    func tappedCategoriesMenu(indexCategory: Int) {
        presenter.scrollCellByCategories(indexCategory: indexCategory)
    }
    
    @objc private func reloadMainTableView() {
        presenter.getMenuInfo()
    }
    
}

//MARK: - Extensions for UITableView
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TableSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch TableSection.allCases[section] {
        case .banners:
            return 1
        case .menuPositions:
            return presenter.getAmountMenuPositions()
        case .loader:
            return presenter.showLoader() ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellForBanners = tableView.dequeueReusableCell(withIdentifier: CellForBanners.key) as? CellForBanners,
              let cellForPosition = tableView.dequeueReusableCell(withIdentifier: CellForMenuPosition.key) as? CellForMenuPosition,
              let loaderCell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.key) as? LoadingTableViewCell else { return UITableViewCell() }
        addParametersForCell(cell: cellForBanners)
        addParametersForCell(cell: cellForPosition)
        addParametersForCell(cell: loaderCell)
        
        switch TableSection.allCases[indexPath.section] {
        case .banners:
            presenter.configureBannerCell(indexPath: indexPath, cell: cellForBanners)
            cellForBanners.delegate = { [weak self] in
                guard let self else { return }
                self.presenter.openWebSite()
            }
            return cellForBanners
        case .menuPositions:
            presenter.configureCellForPositionMenu(indexPath: indexPath, cell: cellForPosition)
            cellForPosition.backgroundColor = .clear
            return cellForPosition
        case .loader:
            loaderCell.backgroundColor = .clear
            return loaderCell
        }
    }
    
    func addParametersForCell(cell: UITableViewCell) {
        cell.updateConstraints()
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.getMenuInfoInPosition(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderViewForСategories()
        view.delegate = self
        return section == 1 ? view : UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 56 : 0
    }
}

