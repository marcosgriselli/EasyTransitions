//
//  PresentationAnimator.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 21/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import EasyTransitions

class PresentationControllerAnimator: ModalTransitionAnimator {

    private var shadowView = UIView()
    private var finalFrame: CGRect
    var auxAnimation: ((Bool) -> Void)?
    var onDismissed: (() -> Void)?

    // TODO: Add configuration.
    init(finalFrame: CGRect) {
        self.finalFrame = finalFrame
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        shadowView.alpha = 0.0
    }
    
    var duration: TimeInterval {
        return 1.0
    }
    
    func layout(presenting: Bool, modalView: UIView, in container: UIView) {
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
    
    func animate(presenting: Bool, modalView: UIView, in container: UIView) {
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
