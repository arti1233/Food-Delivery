import Foundation
import RealmSwift
import UIKit
import SnapKit

protocol CellForPreviousOrderProtocol {
    
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
        label.text = "14.09.2020 18:40"
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
        label.text = "Cost: 450$"
        return label
    }()
    
    private lazy var repeatOrderButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(repeatOrderButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        button.setTitle("Repeat order", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainview)
        mainview.addSubview(dateLabel)
        mainview.addSubview(stackView)
        addPreviousOrderInStackView()
        mainview.addSubview(costLabel)
        mainview.addSubview(repeatOrderButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(order: Results<Basket>) {
    
    }
    
    private func addPreviousOrderInStackView() {
        for i in 0...5 {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "\(i). hfdisdiughfdghusdfhgguhsdiuhgiusdfhgiudfhgiushdfgiuhsdfiughsdfiughsidufghiusdhfgihsdfgiuhsifpughsudfhg"
            stackView.addArrangedSubview(label)
        }
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

