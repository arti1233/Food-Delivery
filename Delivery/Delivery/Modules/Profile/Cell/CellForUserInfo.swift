import Foundation
import UIKit
import SnapKit

protocol CellForUserInfoProtocol {
    func addPhotoButtonTapped()
}

class CellForUserInfo: UITableViewCell {
    
    static var key = "CellForUserInfo"
    var delegate: CellForUserInfoProtocol!
    
    private lazy var viewForProfileImage: UIView = {
        var view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.tintColor = .white
        return view
    }()
    
    private lazy var photoButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var userName: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        label.text = "Artsiom Korenko"
        return label
    }()
    
    private lazy var userPhoneNumberName: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "+375(29) 182-72-84"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(viewForProfileImage)
        viewForProfileImage.addSubview(profileImage)
        contentView.addSubview(photoButton)
        contentView.addSubview(userName)
        contentView.addSubview(userPhoneNumberName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func photoButtonTapped(sender: UIButton) {
        delegate.addPhotoButtonTapped()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        viewForProfileImage.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
            viewForProfileImage.layer.cornerRadius = 20
            viewForProfileImage.transform = viewForProfileImage.transform.rotated(by: -(.pi / 16))
        }
        
        profileImage.snp.makeConstraints {
            $0.height.width.equalTo(80)
            $0.centerX.equalTo(viewForProfileImage.snp_centerXWithinMargins)
            $0.centerY.equalTo(viewForProfileImage.snp_centerYWithinMargins)
            profileImage.transform = profileImage.transform.rotated(by: .pi / 16)
        }
        
        photoButton.snp.makeConstraints {
            $0.centerX.equalTo(viewForProfileImage.snp.trailing).inset(8)
            $0.centerY.equalTo(viewForProfileImage.snp.top)
            $0.height.width.equalTo(40)
        }
        
        userName.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalTo(viewForProfileImage.snp.trailing).offset(24)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        userPhoneNumberName.snp.makeConstraints {
            $0.top.equalTo(userName.snp.bottom).offset(8)
            $0.leading.equalTo(viewForProfileImage.snp.trailing).offset(24)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
