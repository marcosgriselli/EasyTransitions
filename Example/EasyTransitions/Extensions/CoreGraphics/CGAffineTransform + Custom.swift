//
//  CGAffineTransform + Custom.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 12/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGAffineTransform {
    
    public static var galleryLabel: CGAffineTransform {
        return CGAffineTransform(translationX: 0, y: 40.0)
            .concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
    }
}
