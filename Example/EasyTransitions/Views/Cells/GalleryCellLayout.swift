//
//  GalleryCellLayout.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 12/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CoreGraphics

public struct GalleryCellLayout {
    var labelTransform: CGAffineTransform
    var labelAlpha: CGFloat
    var imageViewTransform: CGAffineTransform
    
    private init(labelTransform: CGAffineTransform = .identity,
                 labelAlpha: CGFloat = 1.0,
                 imageViewTransform: CGAffineTransform = .identity) {
        self.labelTransform = labelTransform
        self.labelAlpha = labelAlpha
        self.imageViewTransform = imageViewTransform
    }
    
    public static let standard = GalleryCellLayout()
    public static let converted = GalleryCellLayout(labelTransform: CGAffineTransform.galleryLabel, labelAlpha: 0.2, imageViewTransform: CGAffineTransform(scaleX: 1.5, y: 1.5))
}
