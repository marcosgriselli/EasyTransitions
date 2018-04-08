//
//  ShadowStyle.swift
//  AppStoreTransition
//
//  Created by Marcos Griselli on 18/03/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit

public struct ShadowStyle {
    public let color: CGColor
    public let opacity: Float
    public let radius: CGFloat
    public let offset: CGSize
}

public extension ShadowStyle {
    
    static let todayCard  = ShadowStyle(color: UIColor.black.cgColor,
                                        opacity: 0.2,
                                        radius: 30,
                                        offset: CGSize(width: 0, height: 15))
}

