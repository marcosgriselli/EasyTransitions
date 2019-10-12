//
//  ImageCollectionViewCell.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 12/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

fileprivate extension CGAffineTransform {
    
    static var image: CGAffineTransform {
        return CGAffineTransform(translationX: 0, y: 50.0)
            .concatenating(.init(scaleX: 0.8, y: 0.8))
    }
}

class ImageCollectionViewCell: UICollectionViewCell, NibLoadableView {

    @IBOutlet weak var imageView: UIImageView!
    
    public struct Layout {
        var imageTransform: CGAffineTransform
        var imageAlpha: CGFloat
        
        private init(imageTransform: CGAffineTransform = .identity,
                     imageAlpha: CGFloat = 1.0) {
            self.imageTransform = imageTransform
            self.imageAlpha = imageAlpha
        }
        
        public static let converted = Layout(imageTransform: CGAffineTransform.image,
                                             imageAlpha: 0.0)
        public static let standard = Layout()
    }

    public func set(layout: ImageCollectionViewCell.Layout) {
        imageView.transform = layout.imageTransform
        imageView.alpha = layout.imageAlpha
    }
}
