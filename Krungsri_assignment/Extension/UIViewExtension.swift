//
//  UIButtonExtension.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import Foundation
import UIKit

extension UIView {
    
    func setCornerRadius() {
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func setCornerRadius(radius: Double) {
        self.layer.cornerRadius = radius
    }
    
    func dropShadow() {
           layer.masksToBounds = false
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOpacity = 0.5
           layer.shadowOffset = CGSize(width: -1, height: 1)
           layer.shadowRadius = 1
           layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
           layer.shouldRasterize = true
           layer.rasterizationScale = UIScreen.main.scale
       }

    func dropShadowAtOnlyCorner() {
        // shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2
    }
}
