//
//  PresentationAnimator.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 21/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

open class PresentationControllerAnimator: ModalTransitionAnimator {

    private var finalFrame: CGRect
    private var shadowView = UIView()
    public var auxAnimation: ((Bool) -> Void)?
    public var onDismissed: (() -> Void)?
    public var onPresented: (() -> Void)?

    // TODO: Add configuration.
    public init(finalFrame: CGRect) {
        self.finalFrame = finalFrame
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        shadowView.alpha = 0.0
    }
    
    open var duration: TimeInterval {
        return 1.0
    }
    
    public func layout(presenting: Bool, modalView: UIView, in container: UIView) {
        if presenting {
            modalView.frame = finalFrame
            let yOffset = modalView.frame.origin.y.distance(to: container.bounds.height)
            modalView.frame = modalView.frame.offsetBy(dx: 0,
                                                       dy: yOffset)
            container.addSubview(modalView)
            shadowView.frame = container.frame
            if shadowView.superview == nil {
                container.insertSubview(shadowView, belowSubview: modalView)
            }
        }
    }
    
    public func animate(presenting: Bool, modalView: UIView, in container: UIView) {
        if !presenting {
            let yOffset = modalView.frame.origin.y.distance(to: container.bounds.height)
            modalView.frame = modalView.frame.offsetBy(dx: 0,
                                                       dy: yOffset)
            shadowView.alpha = 0.0
        } else {
            modalView.frame = finalFrame
            shadowView.alpha = 1.0
        }
        auxAnimation?(presenting)
    }
}
