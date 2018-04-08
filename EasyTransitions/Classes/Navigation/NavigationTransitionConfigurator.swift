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
        toView.frame = toFrame.offsetBy(dx: -toFrame.size.width * 0.3, dy: 0)
        
        transitionAnimator.layout(presenting: isPush, fromView: fromView,
                                  toView: toView, in: containerView)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModeLinear, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                self.transitionAnimator.animations(duration: 0, presenting: isPush, fromView: fromView, toView: toView, in: containerView)
            })
            
//            for (index, block) in self.fromAnimationsBlock.enumerated() {
//                let start = Double(index) * 0.1
//                UIView.addKeyframe(withRelativeStartTime: start,
//                                   relativeDuration: 0.2, animations: block)
//            }
//
//            for (index, block) in self.toAnimations.enumerated() {
//                let start = Double(index) * 0.1
//                UIView.addKeyframe(withRelativeStartTime: start,
//                                   relativeDuration: 0.2, animations: block)
//            }
            
        }) { finished in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}
