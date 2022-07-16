//
//  CartViewModel.swift
//  ShoppingAssignment
//
//  Created by AboNabih on 7/13/22.
//

import Foundation
import RxSwift
import RxCocoa

class CartViewModel {
    //MARK: Variable
    let disposeBag = DisposeBag()
    enum ContentLoadingState {
          case ideal
          case loading
          case loaded
      }
    var cars  = BehaviorRelay<[Car]>(value: [])
    var cartItems  = BehaviorRelay<[Car:Int]>(value: [:])
    let loadingState = BehaviorRelay<ContentLoadingState>(value: .ideal)
    
    init() {
        
    }
    func getCart() {
        loadingState.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: { [weak self] in
            guard let self = self else { return }
            ShoppingCart.sharedCart.cartItems.asObservable().observe(on: MainScheduler())
              .subscribe(onNext: { items in
            self.cartItems.accept(items)
            self.loadingState.accept(.loaded)
              })
              .disposed(by: self.disposeBag)
        })
    }

}
