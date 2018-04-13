//
//  TransitionAnimator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

public final class NavigationTransitionConfigurator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let transitionAnimator: NavigationTransitionAnimator
    
    public init(transitionAnimator: NavigationTransitionAnimator) {
        self.transitionAnimator = transitionAnimator
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionAnimator.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        let containerView = transitionContext.containerView
        
        let fromView: UIView
        let toView: UIView
        
        if transitionContext.responds(to: #selector(UIViewControllerContextTransitioning.view(forKey:))) {
            fromView = transitionContext.view(forKey: .from)!
            toView = transitionContext.view(forKey: .to)!
        } else {
            fromView = fromViewController.view
            toView = toViewController.view
        }

        var isPush = false
        if let toIndex = toViewController.navigationController?.viewControllers.index(of: toViewController),
            let fromIndex = fromViewController.navigationController?.viewControllers.index(of: fromViewController) {
            isPush = toIndex > fromIndex
        }
        
        let fromFrame = transitionContext.initialFrame(for: fromViewController)
        let toFrame = transitionContext.finalFrame(for: toViewController)
        
        fromView.frame = fromFrame
        toView.frame = toFrame
        
        transitionAnimator.layout(presenting: isPush, fromView: fromView,
                                  toView: toView, in: containerView)
        
        let duration = transitionDuration(using: transitionContext)
        let auxAnimations = transitionAnimator.auxAnimations(isPush)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                self.transitionAnimator.animations(presenting: isPush,fromView: fromView,
                                                   toView: toView, in: containerView)
            })
            
            for animation in auxAnimations {
                let relativeDuration = duration - animation.delayOffset * duration
                UIView.addKeyframe(withRelativeStartTime: animation.delayOffset,
                                   relativeDuration: relativeDuration,
                                   animations: animation.block)
            }            
        }) { finished in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}
