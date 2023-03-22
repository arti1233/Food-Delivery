import Foundation
import RealmSwift
import UIKit
import SnapKit

protocol CellForPreviousOrderProtocol {
    func configureCell(order: OrdersUser)
}

class CellForPreviousOrder: UITableViewCell {
    
    static var key = "CellForPreviousOrder"
    var delegate: CellForPreviousOrderProtocol!
    
    private lazy var mainview: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 5, height: 4)
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        var view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 16
        return view
    }()
    
    private lazy var costLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    private lazy var repeatOrderButton: BasicButton = {
        var button = BasicButton()
        button.addTarget(self, action: #selector(repeatOrderButtonTapped), for: .touchUpInside)
        button.setTitle("Repeat order", for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainview)
        mainview.addSubview(dateLabel)
        mainview.addSubview(stackView)
        mainview.addSubview(costLabel)
        mainview.addSubview(repeatOrderButton)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = ""
        costLabel.text = ""
        stackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(order: OrdersUser) {
        guard let date = order.date else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, hh:mm"
        dateLabel.text = dateFormatter.string(from: date)
        addPreviousOrderInStackView(order: order)
        addTotalCostOrder(order: order)
    }
    
    private func addPreviousOrderInStackView(order: OrdersUser) {
        for (index, basket) in order.basket.enumerated() {
            guard let namePosition = basket.name else { return }
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "\(index + 1). \(namePosition) x\(basket.countPosition )"
            stackView.addArrangedSubview(label)
        }
    }
    
    private func addTotalCostOrder(order: OrdersUser) {
        var totalSum = 0
        for basket in order.basket {
            guard let cost = basket.cost else { return }
            totalSum += basket.countPosition * cost
        }
        costLabel.text = "\(totalSum) $"
    }
    
    @objc private func repeatOrderButtonTapped(sender: UIButton) {
        
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        mainview.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview().inset(8)
            mainview.layer.cornerRadius = 20
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
        }
        
        costLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(stackView.snp.bottom).offset(16)
        }
        
        repeatOrderButton.snp.makeConstraints {
            $0.top.equalTo(costLabel.snp.bottom).offset(16)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(32)
            $0.bottom.equalToSuperview().inset(16)
            repeatOrderButton.layer.cornerRadius = 16
        }
    }
}

