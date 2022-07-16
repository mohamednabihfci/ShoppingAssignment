//
//  UserStatus.swift
//  Circle
//
//  Created by abonabih abonabih on 7/7/19.
//  Copyright © 2019 Midhun P Mathew. All rights reserved.
//

import Foundation
struct UserStatus {

    static var cartItems: [String:Int] {
        set{
            UserDefaults.standard.set(newValue, forKey: "cartItems")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.object(forKey: "cartItems") as? [String:Int] ?? [:]
        }
    }
    static var cartDate: Date? {
        set{
            UserDefaults.standard.set(newValue, forKey: "cartDate")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.value(forKey: "cartDate") as? Date
        }
    }
}



