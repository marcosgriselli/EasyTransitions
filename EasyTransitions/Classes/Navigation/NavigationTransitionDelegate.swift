//
//  NavigationTransitionDelegate.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 08/04/2018.
//

import Foundation

public class NavigationTransitionDelegate: NSObject {

    private var transitionAnimator: NavigationTransitionAnimator? = .none
    private let interactiveController = TransitionInteractiveController()
    
    public func wire(viewController: UIViewController, with pan: Pan) {
        interactiveController.wireTo(viewController: viewController, with: pan)
        interactiveController.navigationAction = {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
    
    public func set(animator: NavigationTransitionAnimator?) {
        transitionAnimator = animator
    }
}

extension NavigationTransitionDelegate: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // TODO: - Toggle supported operations.
//        if operation == .pop {
//            return nil
//        }
        
        if let animator = transitionAnimator {
            return NavigationTransitionConfigurator(transitionAnimator: animator)
        }
        return nil 
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveController.interactionInProgress ? interactiveController : nil
    }
}
