//
//  ModalTransitionConfigurator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

internal class ModalTransitionConfigurator: NSObject, UIViewControllerAnimatedTransitioning {

    private let transitionAnimator: BaseAnimator
    private var a: UIViewImplicitlyAnimating?

    public init(transitionAnimator: BaseAnimator) {
        self.transitionAnimator = transitionAnimator
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionAnimator.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionAnimator(using: transitionContext).startAnimation()
    }
    
    internal func transitionAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        guard let b = a else {
            a = transitionAnimator.animate(with: transitionContext)
            return a!
        }
        return b
    }
    
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return transitionAnimator(using: transitionContext)
    }
}
