//
//  TransitionAnimator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

public class NavigationTransitionConfigurator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let transitionAnimator: NavigationTransitionAnimator
    
    public init(transitionAnimator: NavigationTransitionAnimator) {
        self.transitionAnimator = transitionAnimator
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionAnimator.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionAnimator(using: transitionContext).startAnimation()
    }
    
    private func transitionAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
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
        
        fromView.frame = transitionContext.initialFrame(for: fromViewController)
        toView.frame = transitionContext.finalFrame(for: toViewController)
        
        transitionAnimator.layout(presenting: isPush, fromView: fromView,
                                  toView: toView, in: containerView)
        
        let duration = transitionDuration(using: transitionContext)
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut)
        animator.addAnimations {
            self.transitionAnimator.animations(duration: duration, presenting: isPush,
                                               fromView: fromView, toView: toView,
                                               in: containerView)
        }
        
        let auxAnimations = transitionAnimator.auxAnimations(isPush)
        auxAnimations.forEach(animator.addAnimations)

        animator.addCompletion { position in
            switch position {
            case .end:
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            default:
                transitionContext.completeTransition(false)
            }
        }
        animator.isUserInteractionEnabled = true
        
        return animator
    }
    
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return transitionAnimator(using: transitionContext)
    }
}
