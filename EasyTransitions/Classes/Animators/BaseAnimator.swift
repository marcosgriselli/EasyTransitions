//
//  BaseAnimator.swift
//  Pods
//
//  Created by Marcos Griselli on 07/06/2018.
//

import Foundation
import UIKit

open class BaseAnimator {
    
    public init() {}
    
    internal weak var context: UIViewControllerContextTransitioning?
    
    open var duration: TimeInterval {
        return 0.5
    }

    open var interactionEnabled: Bool {
        return true
    }
    
    open var onFinish: ((ModalOperation) -> Void) = { _ in }
    open var auxAnimation: AuxAnimation?
    
    internal func animate(with transitionContext: UIViewControllerContextTransitioning) -> UIViewPropertyAnimator {
        context = transitionContext
        let operation: ModalOperation =
            transitionContext.isPresenting ? .present : .dismiss
        var animator: UIViewPropertyAnimator
        switch operation {
        case .present:
            animator = animatePresent(
                modalView: transitionContext.modalView,
                in: transitionContext.containerView
            )
        case .dismiss:
            animator = animateDismiss(
                modalView: transitionContext.modalView,
                in: transitionContext.containerView
            )
        }
    
        if let auxAnimation = auxAnimation {
            animator.addAnimations(
                { auxAnimation.animationBlock(operation) },
                delayFactor: auxAnimation.delayOffset
            )
        }
//        animator.addAnimations { [weak self] in
//            self?.auxAnimation?.animationBlock()

//        }, del

        animator.addCompletion { [weak self] _ in
            self?.onFinish(operation)
        }
        animator.addCompletion { [weak self] position in
            self?.completeTransition(success: position == .end)
        }
        return animator
    }
    
    open func animatePresent(modalView: UIView,
                             in container: UIView) -> UIViewPropertyAnimator {
        fatalError("animatePresent needs to be implemented.")
    }
    
    open func animateDismiss(modalView: UIView,
                             in container: UIView) -> UIViewPropertyAnimator {
        fatalError("animateDismiss needs to be implemented.")
    }
    
    public func completeTransition(success: Bool) {
        context?.completeTransition(success)
        context = nil
    }
}
