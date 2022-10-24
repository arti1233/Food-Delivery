//
//  CellForBanner.swift
//  Delivery
//
//  Created by Artsiom Korenko on 18.10.22.
//

import Foundation
import UIKit
import SnapKit

class CellForListBanner: UICollectionViewCell {
    
    static var key = "CellForListBanner"

    private lazy var layoutCollectionView: UICollectionViewFlowLayout = {
        var view = UICollectionViewFlowLayout()
        view.scrollDirection = .horizontal
        view.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.minimumLineSpacing = 0
        view.minimumInteritemSpacing = 0
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        var view = UICollectionView()
        view.register(CellForBanner.self, forCellWithReuseIdentifier: CellForBanner.key)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        
    }
 
    override func updateConstraints() {
        super.updateConstraints()
      
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        
    }
    
    func addConstreint() {

    }
}

extension CellForListBanner: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellForBanner.key, for: indexPath) as? CellForBanner else { return UICollectionViewCell() }
        return cell
    }
    
    
}
