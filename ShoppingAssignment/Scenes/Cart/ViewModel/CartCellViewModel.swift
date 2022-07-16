//
//  CartCellViewModel.swift
//  ShoppingAssignment
//
//  Created by AboNabih on 7/13/22.
//

import Foundation
import RxSwift
import RxCocoa

class CartCellViewModel {
    
    enum ContentLoadingState {
        case ideal
        case loading
        case loaded
    }
    let loadingState = BehaviorRelay<ContentLoadingState>(value: .ideal)
    
    var cartItem = [Car:Int]() {
        didSet {
            name.accept((cartItem.keys.first)!.name)
            quntity.accept((cartItem.values.first!))
        }
    }
    
    var name  = BehaviorRelay<String>(value: "")
    var quntity  = BehaviorRelay<Int>(value: 1)
    
    init() {}
    
    func updateCart(car: Car, qty: Double) {
        loadingState.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: { [weak self] in
          self?.loadingState.accept(.loaded)
          ShoppingCart.sharedCart.updateCart(car: car, qty: Int(qty))
            
        })
    }
    
}
