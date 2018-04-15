//
//  NavigationTransitionDelegate.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 08/04/2018.
//

import Foundation

open class NavigationTransitionDelegate: NSObject {

    private var animators = [UINavigationControllerOperation: NavigationTransitionAnimator]()
    private let interactiveController = TransitionInteractiveController()
    
    open func wire(viewController: UIViewController, with pan: Pan) {
        interactiveController.wireTo(viewController: viewController, with: pan)
        interactiveController.navigationAction = {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
    
    open func set(animator: NavigationTransitionAnimator,
                  forOperation operation: UINavigationControllerOperation) {
        animators[operation] = animator
    }

    open func removeAnimator(forOperation operation: UINavigationControllerOperation) {
        animators.removeValue(forKey: operation)
    }
}

extension NavigationTransitionDelegate: UINavigationControllerDelegate {
    
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animators[operation] else {
            return nil
        }
        return NavigationTransitionConfigurator(transitionAnimator: animator)
    }
    
    open func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveController.interactionInProgress ? interactiveController : nil
    }
}
