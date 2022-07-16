//
//  HomeCellViewModel.swift
//  ShoppingAssignment
//
//  Created by AboNabih on 7/12/22.
//

import Foundation
import RxSwift
import RxCocoa

class HomeCellViewModel {
    
    enum ContentLoadingState {
          case ideal
          case loading
          case loaded
      }
    
    var car  = BehaviorRelay<Car?>(value: nil)
    var name  = BehaviorRelay<String>(value: "")
    var price  = BehaviorRelay<String>(value: "")

    let loadingState = BehaviorRelay<ContentLoadingState>(value: .ideal)
    
    func addToCart() {
        self.loadingState.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: { [weak self] in
            guard let self = self else { return }
            ShoppingCart.sharedCart.addToCar(car: self.car.value!)
            self.loadingState.accept(.loaded)
        })
    }

    
}
