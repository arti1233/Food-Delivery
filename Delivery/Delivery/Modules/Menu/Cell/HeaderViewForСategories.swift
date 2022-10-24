//
//  HeaderViewForСategories.swift
//  Delivery
//
//  Created by Artsiom Korenko on 21.10.22.
//

import Foundation
import UIKit
import SnapKit

class HeaderViewForСategories: UIView {
    
    static var key = "HeaderViewForСategories"
    
    private lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset.bottom = 24
        layout.sectionInset.top = 24
        layout.itemSize = CGSize(width: 88, height: 32)
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false 
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        collectionView.register(CellForCategories.self, forCellWithReuseIdentifier: CellForCategories.key)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

extension HeaderViewForСategories: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellForCategories.key, for: indexPath) as? CellForCategories else { return UICollectionViewCell() }
        cell.updateConstraints()
        return cell
    }
}
