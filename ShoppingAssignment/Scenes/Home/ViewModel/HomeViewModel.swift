//
//  HomeViewModel.swift
//  ShoppingAssignment
//
//  Created by AboNabih on 7/12/22.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    enum ContentLoadingState {
          case ideal
          case loading
          case loaded
      }
    
    var cars  = BehaviorRelay<[Car]>(value: [])
    let loadingState = BehaviorRelay<ContentLoadingState>(value: .ideal)
    
    init(){
        ShoppingCart.sharedCart.syncData()
    }
    
    func getCars() {
        
        loadingState.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: { [weak self] in
            let chevrolet = Car(name: "Chevrolet")
            let kia = Car(name: "Kia")
            let toyota = Car(name: "Toyota")
            let hyundai = Car(name: "Hyundai")
            let landRover = Car(name: "Land Rover")
            self?.loadingState.accept(.loaded)
            self?.cars.accept([chevrolet,kia,toyota,hyundai,landRover])
          })
    }
    

}
