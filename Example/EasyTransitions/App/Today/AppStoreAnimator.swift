//
//  AppStoreAnimator.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 07/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import EasyTransitions

public class AppStoreAnimator: BaseAnimator {
    
    public var initialFrame: CGRect
    public var onReady: () -> Void = {}
    
    public init(initialFrame: CGRect) {
        self.initialFrame = initialFrame
    }

    public override var duration: TimeInterval {
        return 0.85
    }
    
    public override func animatePresent(modalView: UIView, in container: UIView) -> UIViewPropertyAnimator {
        container.addSubview(modalView)
        modalView.frame = initialFrame
        // TODO: - Solve why I need to call layoutIfNeeded() to avoid
        // the drawing bug.
        modalView.layoutIfNeeded()
        onReady()
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.7) {
            modalView.match(CGRect.verticalKeyPaths, to: container.bounds)
        }
        animator.addAnimations({
            modalView.match(CGRect.horizontalKeyPaths, to: container.bounds)
        }, delayFactor: 0.1)
        return animator
    }
    
    public override func animateDismiss(modalView: UIView, in container: UIView) -> UIViewPropertyAnimator {
        // TODO: - Solve timing issue?
        let animator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
            modalView.match(CGRect.verticalKeyPaths, to: self.initialFrame)
        }
        animator.addAnimations({
            modalView.match(CGRect.horizontalKeyPaths, to: self.initialFrame)
        }, delayFactor: 0.1)
        return animator
    }
}
