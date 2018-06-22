//
//  PresentAnimator.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 07/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import EasyTransitions

class BAnimator: BaseAnimator {
    override func animateDismiss(modalView: UIView, in container: UIView) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            modalView.frame = modalView.frame.offsetBy(dx: container.frame.width,
                                                       dy: 0)
        }
    }
}

class PresentAnimator: BaseAnimator {
    
    private var finalFrame: CGRect

    public init(finalFrame: CGRect) {
        self.finalFrame = finalFrame
        super.init()
    }
    
    override var duration: TimeInterval {
        return 0.35
    }
    
    override func animatePresent(modalView: UIView,
                                 in container: UIView) -> UIViewPropertyAnimator {
        
        modalView.frame = finalFrame
        modalView.frame = modalView.frame.offsetBy(
            dx: 0,
            dy: modalView.frame.origin.y.distance(to: container.bounds.height)
        )
        
        container.addSubview(modalView)
        
        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: .easeOut) {
                modalView.frame = self.finalFrame
        }

        return animator
    }

    override func animateDismiss(modalView: UIView,
                             in container: UIView) -> UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: .easeIn) {
                modalView.frame = modalView.frame.offsetBy(
                    dx: 0,
                    dy: modalView.frame.origin.y.distance(to: container.bounds.height)
                )
        }

        return animator
    }
}
