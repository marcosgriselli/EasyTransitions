//
//  TransitionInteractiveController.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

open class TransitionInteractiveController: UIPercentDrivenInteractiveTransition {

    // MARK: - Private
    private weak var viewController: UIViewController?
    private var gestureRecognizer: UIPanGestureRecognizer?
    private var shouldCompleteTransition = false
    
    private struct InteractionConstants {
        static let velocityForComplete: CGFloat = 100.0
        static let velocityForCancel: CGFloat = -5.0
    }
    
    // MARK: - Public
    
    /// enables/disables the entire interactor.
    open var isEnabled = true {
        didSet { gestureRecognizer?.isEnabled = isEnabled }
    }
    open var interactionInProgress = false
    open var completeOnPercentage: CGFloat = 0.5
    open var navigationAction: (() -> Void) = {
        fatalError("Missing navigationAction (ex: navigation.dismiss) on TransitionInteractiveController")
    }
    open var shouldBeginTransition: () -> Bool = { return true }
    
    deinit {
        if let gestureRecognizer = gestureRecognizer {
            viewController?.view.removeGestureRecognizer(gestureRecognizer)
        }
    }
    
    /// Sets the viewController to be the one in charge of handling the swipe transition.
    ///
    /// - Parameter viewController: `UIViewController` in charge of the the transition.
    open func wireTo(viewController: UIViewController, with pan: Pan) {
        self.viewController = viewController
        gestureRecognizer = PanFactory.create(with: pan)
        gestureRecognizer?.addTarget(self, action: #selector(handle(_:)))
        gestureRecognizer?.delegate = self
        gestureRecognizer?.isEnabled = isEnabled
        self.viewController?.view.addGestureRecognizer(gestureRecognizer!)
    }
    
    /// Handles the swiping with progress
    ///
    /// - Parameter recognizer: `UIPanGestureRecognizer` in the current tab controller's view.
    @objc open func handle(_ recognizer: UIGestureRecognizer) {
        guard let panGesture = recognizer as? PanGesture else { return }
        let panVelocity = panGesture.velocityForPan()
        let panned = panGesture.percentagePanned()
        switch recognizer.state {
        case .began:
            if panVelocity > 0 && shouldBeginTransition() {
                interactionInProgress = true
                navigationAction()
            }
        case .changed:
            if interactionInProgress {
                let fraction = min(max(panned, 0.0), 0.999)
                update(fraction)
            }
        case .ended, .cancelled:
            if interactionInProgress {
                interactionInProgress = false
                shouldCompleteTransition = (panned > completeOnPercentage ||                panVelocity > InteractionConstants.velocityForComplete) &&
                    panVelocity > InteractionConstants.velocityForCancel
                // TODO: - Calculate correctly.
                completionSpeed = abs(panVelocity / 1000) + 1.0
                shouldCompleteTransition ? finish() : cancel()
            }
            
        default : break
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension TransitionInteractiveController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panGesture = gestureRecognizer as? PanGesture else {
            return false
        }
        let panVelocity = panGesture.velocityForPan()
        return panVelocity > 0 && shouldBeginTransition()
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
