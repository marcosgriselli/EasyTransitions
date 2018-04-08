//
//  TransitionAnimator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

public class NavigationTransitionConfigurator: NSObject, UIViewControllerAnimatedTransitioning {

    private var currentAnimator: UIViewImplicitlyAnimating?
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
        
        // For a Push:
        //      fromView = The current top view controller.
        //      toView   = The incoming view controller.
        // For a Pop:
        //      fromView = The outgoing view controller.
        //      toView   = The new top view controller.
        let fromView: UIView
        let toView: UIView
        
        // In iOS 8, the viewForKey: method was introduced to get views that the
        // animator manipulates.  This method should be preferred over accessing
        // the view of the fromViewController/toViewController directly.
        if transitionContext.responds(to: #selector(UIViewControllerContextTransitioning.view(forKey:))) {
            fromView = transitionContext.view(forKey: .from)!
            toView = transitionContext.view(forKey: .to)!
        } else {
            fromView = fromViewController.view
            toView = toViewController.view
        }
        
        // If a push is being animated, the incoming view controller will have a
        // higher index on the navigation stack than the current top view
        // controller.
        var isPush = false
        if let toIndex = toViewController.navigationController?.viewControllers.index(of: toViewController),
            let fromIndex = fromViewController.navigationController?.viewControllers.index(of: fromViewController) {
            isPush = toIndex > fromIndex
        }
        
        fromView.frame = transitionContext.initialFrame(for: fromViewController)
        toView.frame = transitionContext.finalFrame(for: toViewController)
        
        // We are responsible for adding the incoming view to the containerView
        // for the transition.
        transitionAnimator.layout(presenting: isPush, fromView: fromView,
                                  toView: toView, in: containerView)
        
        let duration = transitionDuration(using: transitionContext)
        transitionAnimator.performAnimation(duration: duration, presenting: isPush, fromView: fromView, toView: toView, in: containerView) {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
