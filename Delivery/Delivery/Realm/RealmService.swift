//
//  RealmService.swift
//  Delivery
//
//  Created by Artsiom Korenko on 26.11.22.
//

import Foundation
import RealmSwift
import UIKit


// Realm model
class Basket: Object {
    @Persisted(primaryKey: true) var image: String?
    @Persisted var name: String?
    @Persisted var cost: Int?
    @Persisted var descriptionPosition: String?
    @Persisted var countPosition: Int = 0
}

protocol RealmServiceProtocol {
    func addPositionInBasket(menuInfo: Menu, countPosition: Int)
    func realmUrl()
}

class RealmService: RealmServiceProtocol {
    
    private let realm = try! Realm()
    
    func addPositionInBasket(menuInfo: Menu, countPosition: Int) {
        
        let basket = Basket()
        basket.cost = menuInfo.cost
        basket.name = menuInfo.name
        basket.image = menuInfo.image
        basket.descriptionPosition = menuInfo.description
        basket.countPosition = countPosition
        
        try! realm.write {
            realm.add(basket)
        }
    }
    
    func realmUrl() {
       print(realm.configuration.fileURL?.description) 
    }
    
}


