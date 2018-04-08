//
//  ModalTransitionConfigurator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

@available(iOS 10.0, *)
public class ModalTransitionConfigurator: NSObject, UIViewControllerAnimatedTransitioning {

    private let transitionAnimator: ModalTransitionAnimator
    private var animator: UIViewImplicitlyAnimating?
    
    public init(transitionAnimator: ModalTransitionAnimator) {
        self.transitionAnimator = transitionAnimator
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionAnimator.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let currentAnimator = animator else {
            animator = transitionAnimator(using: transitionContext)
            animator?.startAnimation()
            return
        }
        currentAnimator.startAnimation()
    }
    
     private func transitionAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        let containerView = transitionContext.containerView
        let isPresenting = (toViewController.presentingViewController === fromViewController)

        let modalView: UIView
        if transitionContext.responds(to: #selector(UIViewControllerContextTransitioning.view(forKey:))) {
            let key: UITransitionContextViewKey = isPresenting ? .to : .from
            modalView = transitionContext.view(forKey: key)!
        } else {
            modalView = isPresenting ? toViewController.view : fromViewController.view
        }

        transitionAnimator.layout(presenting: isPresenting, modalView: modalView, in: containerView)
        
        let duration = transitionDuration(using: transitionContext)
        return transitionAnimator.performAnimation(duration: duration, presenting: isPresenting, modalView: modalView, in: containerView) {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }!
    }
    
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        guard let currentAnimator = animator else {
            animator = transitionAnimator(using: transitionContext)
            return animator!
        }
        return currentAnimator
    }
}
