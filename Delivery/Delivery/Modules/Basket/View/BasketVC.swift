import Foundation
import UIKit
import SnapKit

protocol BasketVCProtocol: AnyObject {
    func reloadVC(totalSum: Int)
    func isBasketEmpty(result: Bool)
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
    
    private lazy var menuButton: BasicButton = {
        var button = BasicButton()
        button.setTitle("Go to menu", for: .normal)
        button.addTarget(self, action: #selector(goToMenu), for: .touchUpInside)
        return button
    }()
    
    private lazy var segmentController: BasicSegmentController = {
        var segmentController = BasicSegmentController(items: ["Delivery", "Pickup"])
        segmentController.addTarget(self, action: #selector(changeView(_:)), for: .valueChanged)
        return segmentController
    }()
    
    private lazy var nextButton: BasicButton = {
        var button = BasicButton()
        button.setTitle("Next step", for: .normal)
        button.addTarget(self, action: #selector(nextToDelivery), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .basicBackgroundColor
        tableView.register(CellFopBasketPosition.self, forCellReuseIdentifier: CellFopBasketPosition.key)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var totalSumLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    private lazy var slideMenuButton: SlideMenuButtonForNavBar = {
        var button = SlideMenuButtonForNavBar(type: .system)
        button.addTarget(self, action: #selector(slideMenuButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var presenter: BasketPresenterProtocol? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: slideMenuButton)
        view.addSubview(menuButton)
        view.addSubview(transitionToMenuLabel)
        view.addSubview(emptyBasketLabel)
        view.addSubview(segmentController)
        view.addSubview(tableView)
        view.addSubview(nextButton)
        view.addSubview(totalSumLabel)
        title = "Basket"
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         navigationController?.navigationBar.shouldRemoveShadow(true)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        menuButton.snp.makeConstraints {
            $0.width.equalTo(view.frame.width / 2)
            $0.height.equalTo(40)
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
        }
        
        transitionToMenuLabel.snp.makeConstraints {
            $0.width.equalTo(view.frame.width * 0.6)
            $0.centerX.equalTo(view.snp.centerX)
            $0.bottom.equalTo(menuButton.snp.top).offset(-16)
        }
        
        emptyBasketLabel.snp.makeConstraints {
            $0.width.equalTo(view.frame.width * 0.6)
            $0.centerX.equalTo(view.snp.centerX)
            $0.bottom.equalTo(transitionToMenuLabel.snp.top).offset(-8)
        }
                
        segmentController.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(40)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(40)
            $0.width.equalTo(view.frame.width * 0.65)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8)
        }
        
        totalSumLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalTo(nextButton.snp.leading).offset(8)
            $0.centerY.equalTo(nextButton.snp.centerY)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(segmentController.snp.bottom).offset(16)
            $0.bottom.equalTo(nextButton.snp.top).offset(-8)
        }
    }

//MARK: - Metods for protocol
    
    func reloadVC(totalSum: Int) {
        tableView.reloadData()
        totalSumLabel.text = "Total: \(totalSum.description) $"
    }
    
    func isBasketEmpty(result: Bool)  {
        if result {
            emptyBasketLabel.isHidden = false
            transitionToMenuLabel.isHidden = false
            menuButton.isHidden = false
            segmentController.isHidden = true
            nextButton.isHidden = true
            tableView.isHidden = true
            totalSumLabel.isHidden = true
        } else {
            emptyBasketLabel.isHidden = true
            transitionToMenuLabel.isHidden = true
            menuButton.isHidden = true
            segmentController.isHidden = false
            nextButton.isHidden = false
            tableView.isHidden = false
            totalSumLabel.isHidden = false
        }
    }
    
//MARK: - Actions
    @objc private func changeView(_ sender: UISegmentedControl) {
        
    }
    
    @objc private func slideMenuButtonPressed(sender: UIButton) {
        guard let tabBarController else { return }
        presenter?.showSlideMenu(tabBarController: tabBarController)
    }
    
    @objc private func nextToDelivery(sender: UIButton) {
        guard let presenter else { return }
        presenter.nextStepButtonTapped()
    }
    
    @objc private func goToMenu(sender: UIButton) {
        guard let presenter, let tabBarController else { return }
        presenter.goToMenuButtonTapped(tabBar: tabBarController)
    }
}

//MARK: - Extension for UITableView
extension BasketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter else { return 0 }
        return presenter.getCountPosition()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter,
              let cell = tableView.dequeueReusableCell(withIdentifier: CellFopBasketPosition.key) as? CellFopBasketPosition else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.updateConstraints()
        cell.prepareForReuse()
        cell.closureForMinusButton = {
            presenter.minusButtonTapped(indexPath: indexPath)
        }
        cell.closureForPlusButton = {
            presenter.plusButtonTapped(indexPath: indexPath)
        }
        presenter.configurePositionCell(indexPath: indexPath, cell: cell)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter else { return }
        presenter.getMenuInfoInPosition(indexPath: indexPath)
    }
}
