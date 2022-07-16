//
//  UIView+Extension.swift
//  ShoppingAssignment
//
//  Created by AboNabih on 7/13/22.
//

import UIKit

extension UIView {

    func cardViewAppearance(cornerRadius: CGFloat = 8.0,
                               shadowOffset: CGSize = CGSize(width: 0, height: 2),
                               shadowColor: UIColor = UIColor(red:0, green:0, blue:0, alpha:0.1),
                               shadowOpacity:CGFloat  = 1,
                               shadowRadius: CGFloat = 4.0) {
           
           layer.cornerRadius = cornerRadius
           //layer.masksToBounds = true
           layer.shadowOffset = shadowOffset
           layer.shadowColor = shadowColor.cgColor
           layer.shadowOpacity = Float(shadowOpacity)
           layer.shadowRadius = shadowRadius

       }
}
