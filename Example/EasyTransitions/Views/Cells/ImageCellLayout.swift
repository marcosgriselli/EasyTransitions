//
//  ImageCellLayout.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 12/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CoreGraphics

fileprivate extension CGAffineTransform {
    
    fileprivate static var image: CGAffineTransform {
        return CGAffineTransform(translationX: 0, y: 50.0)
            .concatenating(.init(scaleX: 0.8, y: 0.8))
    }
}

public struct ImageCellLayout {
    var imageTransform: CGAffineTransform
    var imageAlpha: CGFloat
    
    private init(imageTransform: CGAffineTransform = .identity,
                 imageAlpha: CGFloat = 1.0) {
        self.imageTransform = imageTransform
        self.imageAlpha = imageAlpha
    }
    
    public static let converted = ImageCellLayout(imageTransform: CGAffineTransform.image,
                                                  imageAlpha: 0.0)
    public static let standard = ImageCellLayout()
}
