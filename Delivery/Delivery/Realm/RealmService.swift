import Foundation
import RealmSwift
import UIKit

class UserInfo: Object {
    @Persisted(primaryKey: true) var phoneNumber: String
    @Persisted var name: String?
    @Persisted var lastName: String?
    @Persisted var userAddress: String?
    @Persisted var flat: Int?
    @Persisted var entrance: Int?
    @Persisted var floor: Int?
    @Persisted var orders: OrdersUser?
}

class OrdersUser: Object {
    @Persisted var date: Date?
    @Persisted var basket: MutableSet<Basket>
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
    func addBasketInOrderHistory()
    func getOrderHistory() -> Results<OrdersUser>
    func addUserInfoInRealm(userInfo: UserInfo)
}

class RealmService: RealmServiceProtocol {
    
    private let realm = try! Realm()
    
    func addBasketInOrderHistory() {
        let order = OrdersUser()
        order.date = Date()
        getAllPositionInBasket().forEach({order.basket.insert($0)})
        
        do {
            try realm.write { realm.add(order) }
        } catch {
            print("Чет не получилось")
        }
    }
    
    func addUserInfoInRealm(userInfo: UserInfo) {
        do {
            try realm.write { realm.add(userInfo) }
        } catch {
            print("Чет не получилось при добавлении user info")
        }
    }
    
    func getOrderHistory() -> Results<OrdersUser> {
        realm.objects(OrdersUser.self)
    }
    
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
        print(realm.configuration.fileURL?.description ?? "")
    }
    
}


