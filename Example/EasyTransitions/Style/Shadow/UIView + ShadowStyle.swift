//
//  UIView + ShadowStyle.swift
//  AppStoreTransition
//
//  Created by Marcos Griselli on 18/03/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit

public extension UIView {

    func set(shadowStyle style: ShadowStyle) {
        layer.shadowColor = style.color
        layer.shadowOpacity = style.opacity
        layer.shadowRadius = style.radius
        layer.shadowOffset = style.offset
    }
}
