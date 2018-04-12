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
    
    public func configure(item: GalleryItem) {
        backgroundImageView.image = UIImage(named: item.imageName)
        label.text = item.title
    }

    public func set(layout: GalleryCellLayout) {
        label.transform = layout.labelTransform
        label.alpha = layout.labelAlpha
        backgroundImageView.transform = layout.imageViewTransform
    }
}
