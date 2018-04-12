//
//  ImageCollectionViewCell.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 12/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell, NibLoadableView {

    @IBOutlet weak var imageView: UIImageView!

    public func set(layout: ImageCellLayout) {
        imageView.transform = layout.imageTransform
        imageView.alpha = layout.imageAlpha
    }
}
