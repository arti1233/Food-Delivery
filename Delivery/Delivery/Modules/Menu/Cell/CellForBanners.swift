//
//  HeaderForBanner.swift
//  Delivery
//
//  Created by Artsiom Korenko on 21.10.22.
//

import Foundation
import SnapKit
import UIKit

protocol CellForBannersProtocol {
    func configureCellForBanner(bannersArray: [UIImage])
}

class CellForBanners: UITableViewCell, CellForBannersProtocol {
    
    static var key = "CellForBanners"
    private var banners: [UIImage] = []
 
    private lazy var collectonForBanner: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 112)
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16,
                                           left: 16,
                                           bottom: 12,
                                           right: 16)
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.key)
        return collectionView
    }()
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        var spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        spinner.color = .systemPink
        return spinner
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectonForBanner)
        contentView.addSubview(spinnerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        collectonForBanner.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
            $0.height.equalTo(136)
        }
        
        spinnerView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
    }
    
    func configureCellForBanner(bannersArray: [UIImage]) {
        spinnerView.startAnimating()
        banners = bannersArray
        if !banners.isEmpty {
            collectonForBanner.reloadData()
            spinnerView.stopAnimating()
        }
    }
}

//MARK: - Extension for CellForBanners
extension CellForBanners: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.key, for: indexPath) as? BannerCell else { return UICollectionViewCell() }
        cell.updateConstraints()
        cell.configureCell(image: banners[indexPath.row])
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowOffset = CGSize(width: 5, height: 4)
        return cell
    }
}
