import Foundation
import UIKit
import SnapKit



protocol CellFopBasketPositionProtocol {
    func configureCell(menuInfo: Basket, image: UIImage)
}

class CellFopBasketPosition: UITableViewCell, CellFopBasketPositionProtocol {
    static var key = "CellFopBasketPosition"
    
    var closureForPlusButton: (() -> ())?
    var closureForMinusButton: (() -> ())?
    
    private lazy var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .basicWhiteColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 5, height: 4)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var menuImageView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var numberPositionsLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 2
        return label
    }()
    
    
    private lazy var viewForCost: UIView = {
        var view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor.basicButtonColor.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var costLabel: UILabel = {
        var label = UILabel()
        label.textColor = .basicButtonColor
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var plusButton: BasicButton = {
        var button = BasicButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(plusButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var minusButton: BasicButton = {
        var button = BasicButton()
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.addTarget(self, action: #selector(minusButtonTap), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainView)
        mainView.addSubview(menuImageView)
        mainView.addSubview(numberPositionsLabel)
        mainView.addSubview(nameLabel)
        mainView.addSubview(descriptionLabel)
        mainView.addSubview(viewForCost)
        viewForCost.addSubview(costLabel)
        mainView.addSubview(minusButton)
        mainView.addSubview(plusButton)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        costLabel.text = ""
        menuImageView.image = UIImage()
        numberPositionsLabel.text = ""
        descriptionLabel.text = ""
        nameLabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func plusButtonTap(sender: UIButton) {
        guard let closureForPlusButton else { return }
        closureForPlusButton()
    }
    
    @objc func minusButtonTap(sender: UIButton) {
        guard let closureForMinusButton else { return }
        closureForMinusButton()
    }
    
    func configureCell(menuInfo: Basket, image: UIImage) {
        guard let cost = menuInfo.cost,
              let description = menuInfo.descriptionPosition else { return }
        menuImageView.image = image
        numberPositionsLabel.text = menuInfo.countPosition.description
        nameLabel.text = menuInfo.name
        descriptionLabel.text = description
        costLabel.text = "\(cost) $"
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        mainView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview().inset(8)
        }
        
        menuImageView.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.top.bottom.leading.equalToSuperview().inset(16)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(menuImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(menuImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(8)
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        viewForCost.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(32)
            $0.width.equalTo(87)
        }
        
        costLabel.snp.makeConstraints {
            $0.centerX.equalTo(viewForCost.snp.centerX)
            $0.centerY.equalTo(viewForCost.snp.centerY)
            $0.leading.trailing.equalToSuperview()
        }
        
        minusButton.snp.makeConstraints {
            $0.leading.equalTo(menuImageView.snp.trailing).offset(16)
            $0.centerY.equalTo(viewForCost.snp.centerY)
            $0.width.height.equalTo(30)
        }
        
        numberPositionsLabel.snp.makeConstraints {
            $0.leading.equalTo(minusButton.snp.trailing)
            $0.width.equalTo(30)
            $0.centerY.equalTo(viewForCost.snp.centerY)
        }
        
        plusButton.snp.makeConstraints {
            $0.leading.equalTo(numberPositionsLabel.snp.trailing)
            $0.centerY.equalTo(viewForCost.snp.centerY)
            $0.width.height.equalTo(30)
        }
    }
}
