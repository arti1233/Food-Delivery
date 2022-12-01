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
    @Persisted var countPosition: Int = 1
}

protocol RealmServiceProtocol {
    func addPositionInBasket(menuInfo: Menu, countPosition: Int)
    func realmUrl()
    func isThereElementInRealm(menuInfo: Menu) -> Basket?
    func getAllPositionInBasket() -> Results<Basket>
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
        
        do {
            try realm.write { realm.add(basket, update: .modified) }
        } catch {
            print("Чет не получилось")
        }
    
    }
    
    func getAllPositionInBasket() -> Results<Basket> {
        realm.objects(Basket.self)
    }
    
    func isThereElementInRealm(menuInfo: Menu) -> Basket? {
        let basket = realm.object(ofType: Basket.self, forPrimaryKey: "\(menuInfo.image)")
        guard let basket else { return nil }
        return basket
    }
    
    
    func realmUrl() {
       print(realm.configuration.fileURL?.description) 
    }
    
}


