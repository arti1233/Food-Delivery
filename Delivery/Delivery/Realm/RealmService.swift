import Foundation
import RealmSwift
import UIKit

class UserInfo: Object {
    @Persisted(primaryKey: true) var index: Int
    @Persisted var phoneNumber: Int
    @Persisted var name: String
    @Persisted var lastName: String?
    @Persisted var userAddress: String
    @Persisted var flat: Int?
    @Persisted var entrance: Int?
    @Persisted var floor: Int?
}

class OrdersUser: Object {
    @Persisted var basket: Basket?
}

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
    func deleteObject(basket: Basket)
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
    
    
    
    func deleteObject(basket: Basket) {
        let object = basket
        do {
            try realm.write { realm.delete(basket) }
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


