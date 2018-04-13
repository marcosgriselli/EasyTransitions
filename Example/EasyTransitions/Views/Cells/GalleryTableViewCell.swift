//
//  GalleryTableViewCell.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 12/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    public struct Layout {
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
        
        public static let standard = Layout()
        public static let converted = Layout(labelTransform: CGAffineTransform.galleryLabel, labelAlpha: 0.2, imageViewTransform: CGAffineTransform(scaleX: 1.5, y: 1.5))
    }
    
    public func configure(item: GalleryItem) {
        backgroundImageView.image = UIImage(named: item.imageName)
        label.text = item.title
    }

    public func set(layout: GalleryTableViewCell.Layout) {
        label.transform = layout.labelTransform
        label.alpha = layout.labelAlpha
        backgroundImageView.transform = layout.imageViewTransform
    }
}
