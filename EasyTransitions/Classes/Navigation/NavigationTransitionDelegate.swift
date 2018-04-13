//
//  NavigationTransitionDelegate.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 08/04/2018.
//

import Foundation

open class NavigationTransitionDelegate: NSObject {

    private var transitionAnimator: NavigationTransitionAnimator? = .none
    private let interactiveController = TransitionInteractiveController()
    
    open func wire(viewController: UIViewController, with pan: Pan) {
        interactiveController.wireTo(viewController: viewController, with: pan)
        interactiveController.navigationAction = {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
    
    open func set(animator: NavigationTransitionAnimator?) {
        transitionAnimator = animator
    }
}

extension NavigationTransitionDelegate: UINavigationControllerDelegate {
    
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // TODO: - Support operation configuration.
//        if operation == .push {
//            return nil
//        }
        
        if let animator = transitionAnimator {
            return NavigationTransitionConfigurator(transitionAnimator: animator)
        }
        return nil 
    }
    
    open func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveController.interactionInProgress ? interactiveController : nil
    }
}
