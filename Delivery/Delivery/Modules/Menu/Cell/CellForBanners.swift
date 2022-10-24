//
//  HeaderForBanner.swift
//  Delivery
//
//  Created by Artsiom Korenko on 21.10.22.
//

import Foundation
import SnapKit
import UIKit

class CellForBanners: UITableViewCell {
    
    static var key = "CellForBanners"
    
    private lazy var collectonForBanner: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 112)
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 24,
                                           left: 16,
                                           bottom: 0,
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectonForBanner)
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
    }
}

//MARK: - Extension for CellForBanners

extension CellForBanners: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.key, for: indexPath) as? BannerCell else { return UICollectionViewCell() }
        cell.updateConstraints()
        return cell
    }
}
