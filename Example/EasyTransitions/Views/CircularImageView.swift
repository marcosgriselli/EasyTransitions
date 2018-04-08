//
//  CircularImageView.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 08/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = min(bounds.size.width, bounds.size.height)/2
    }
}
