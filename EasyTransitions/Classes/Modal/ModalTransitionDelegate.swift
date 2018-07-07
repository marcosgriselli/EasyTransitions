//
//  ModalTransitionDelegate.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import Foundation
import UIKit

open class ModalTransitionDelegate: NSObject {

    private var animators = [ModalOperation: ModalTransitionAnimator]()
    private let interactiveController = TransitionInteractiveController()
    private var presentationController: UIPresentationController?
    
    open func wire(viewController: UIViewController,
                   with pan: Pan,
                   navigationAction: @escaping () -> Void,
                   beginWhen: @escaping (() -> Bool) = { return true }) {
        interactiveController.wireTo(viewController: viewController, with: pan)
        interactiveController.navigationAction = navigationAction
        interactiveController.shouldBeginTransition = beginWhen
    }

    open func set(animator: ModalTransitionAnimator, for operation: ModalOperation) {
        animators[operation] = animator
    }
    
    open func removeAnimator(for operation: ModalOperation) {
        animators.removeValue(forKey: operation)
    }
    
    open func set(presentationController: UIPresentationController?) {
        self.presentationController = presentationController
    }
    
    private func configurator(for operation: ModalOperation) -> ModalTransitionConfigurator? {
        guard let animator = animators[operation] else {
            return nil
        }
        return ModalTransitionConfigurator(transitionAnimator: animator)
    }
}

extension ModalTransitionDelegate: UIViewControllerTransitioningDelegate {
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return configurator(for: .present)
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return configurator(for: .dismiss)
    }
    
    open func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveController.interactionInProgress ? interactiveController : nil
    }
    
    open func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveController.interactionInProgress ? interactiveController : nil
    }
    
    open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return presentationController
    }
}
