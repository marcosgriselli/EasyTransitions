//
//  NSLayoutConstraint + Multiplier.swift
//  AppStoreTransition
//
//  Created by Marcos Griselli on 24/03/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        guard let firstItem = firstItem else {
            fatalError("First Item missing on: \(self) while trying to change it's multiplier")
        }
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
