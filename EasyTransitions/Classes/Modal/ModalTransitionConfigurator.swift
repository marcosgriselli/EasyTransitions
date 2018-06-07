//
//  ModalTransitionConfigurator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

internal class ModalTransitionConfigurator: NSObject, UIViewControllerAnimatedTransitioning {

    private let transitionAnimator: BaseAnimator

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
        return transitionAnimator.animate(with: transitionContext)
    }
    
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return transitionAnimator(using: transitionContext)
    }
}
