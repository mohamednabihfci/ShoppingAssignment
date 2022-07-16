
import Foundation
import RxSwift
import RxCocoa

class ShoppingCart {
  static let sharedCart = ShoppingCart()
  let cars: BehaviorRelay<[Car]> = BehaviorRelay(value: [])
  let cartItems  = BehaviorRelay<[Car:Int]>(value: [:])
}
extension ShoppingCart {
    
    func addToCar(car: Car) {
        var newValue =  ShoppingCart.sharedCart.cartItems.value
        if let _ = newValue[car] {
            newValue[car]! += 1
        } else {
            newValue[car] = 1
        }
        ShoppingCart.sharedCart.cartItems.accept(newValue)
        if UserStatus.cartDate == nil {
            UserStatus.cartDate = Date()
        }
    }
    
    func updateCart(car: Car,qty: Int) {
        var newValue =  ShoppingCart.sharedCart.cartItems.value
        if let _ = newValue[car] {
            newValue[car]! = qty
        }
        if qty == 0 {
            newValue[car] = nil
        }
        ShoppingCart.sharedCart.cartItems.accept(newValue)
    }
    
    func saveData() {

        for (key,value) in ShoppingCart.sharedCart.cartItems.value {
            UserStatus.cartItems[key.name] = value
        }
    }
    func syncData() {
        var items = [Car:Int]()
        for (key,value) in UserStatus.cartItems {
           items[Car(name: key)] = value
        }
        ShoppingCart.sharedCart.cartItems.accept(items)
    }
    func clearCart() {
        if let cartDate = UserStatus.cartDate {
            let differance = Date() - cartDate
            if differance.asDays() >= 3 {
                UserStatus.cartItems = [:]
                ShoppingCart.sharedCart.cartItems.accept([:])
                UserStatus.cartDate = nil
            }
        }
    }
}
