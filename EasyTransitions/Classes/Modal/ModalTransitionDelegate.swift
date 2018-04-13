//
//  ModalTransitionDelegate.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import Foundation

open class ModalTransitionDelegate: NSObject {

    private var transitionAnimator: ModalTransitionAnimator? = .none
    private let interactiveController = TransitionInteractiveController()
    
    open func wire(viewController: UIViewController, with pan: Pan) {
        interactiveController.wireTo(viewController: viewController, with: pan)
        interactiveController.navigationAction = {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
    
    open func set(animator: ModalTransitionAnimator?) {
        transitionAnimator = animator
    }
}

extension ModalTransitionDelegate: UIViewControllerTransitioningDelegate {
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let transitionAnimator = transitionAnimator else {
            return nil
        }
        return ModalTransitionConfigurator(transitionAnimator: transitionAnimator)
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let transitionAnimator = transitionAnimator else {
            return nil
        }
        return ModalTransitionConfigurator(transitionAnimator: transitionAnimator)
    }
    
    open func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveController.interactionInProgress ? interactiveController : nil
    }
}
