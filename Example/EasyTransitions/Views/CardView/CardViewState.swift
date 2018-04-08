//
//  CardViewState.swift
//  Transitions_Example
//
//  Created by Marcos Griselli on 31/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public struct CardViewLayout {

    // MARK: - Properties
    public let aspectRatio: CGFloat
    public let cornerRadius: CGFloat
    public let topOffset: CGFloat
    public let closeButtonAlpha: CGFloat
    
    // MARK: - Init
    private init(aspectRatio: CGFloat, cornerRadius: CGFloat, topOffset: CGFloat, closeButtonAlpha: CGFloat) {
        self.aspectRatio = aspectRatio
        self.cornerRadius = cornerRadius
        self.topOffset = topOffset
        self.closeButtonAlpha = closeButtonAlpha
    }

    // MARK: - Layouts
    public static let collapsed = CardViewLayout(aspectRatio: 335/412,
                                                 cornerRadius: 13,
                                                 topOffset: 20,
                                                 closeButtonAlpha: 0)

    public static let expanded = CardViewLayout(aspectRatio: 375/492,
                                                cornerRadius: 0,
                                                topOffset: 20 + UIWindow.safeAreaTopInset,
                                                closeButtonAlpha: 1)
}
