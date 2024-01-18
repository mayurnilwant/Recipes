//
//  UIImageView+Extension.swift
//  Recipes
//
//  Created by Mayur Nilwant on 17/01/2024.
//

import Foundation
import UIKit


extension UIImageView {
    
    func circularImage(withBorderWidth bWidth: Float, andBorderColor bColor : UIColor = .black) {
        
        let cons = self.constraints.filter {
            $0.firstAttribute == NSLayoutConstraint.Attribute.width
        }
        
        let widthCon = cons.first
        self.layer.cornerRadius = (widthCon?.constant ?? 100.0)/2
        self.layer.borderWidth = CGFloat(bWidth)
        self.layer.borderColor = bColor.cgColor
        
    }
}
