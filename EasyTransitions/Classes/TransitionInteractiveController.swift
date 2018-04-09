//
//  TransitionInteractiveController.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

public class TransitionInteractiveController: UIPercentDrivenInteractiveTransition {

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
    public var isEnabled = true {
        didSet { gestureRecognizer?.isEnabled = isEnabled }
    }
    public var interactionInProgress = false
    public var completeOnPercentage: CGFloat = 0.5
    public var navigationAction: (() -> Void) = {
        fatalError("Missing navigationAction (ex: navigation.dismiss) on TransitionInteractiveController")
    }
    
    deinit {
        if let gestureRecognizer = gestureRecognizer {
            viewController?.view.removeGestureRecognizer(gestureRecognizer)
        }
    }
    
    /// Sets the viewController to be the one in charge of handling the swipe transition.
    ///
    /// - Parameter viewController: `UIViewController` in charge of the the transition.
    public func wireTo(viewController: UIViewController, with pan: Pan) {
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
    @objc func handle(_ recognizer: UIGestureRecognizer) {
        guard let panGesture = recognizer as? PanGesture else { return }
        let panVelocity = panGesture.velocityForPan()
        let panned = panGesture.percentagePanned()
        switch recognizer.state {
        case .began:
            if panVelocity > 0 {
                interactionInProgress = true
                navigationAction()
            }
        case .changed:
            if interactionInProgress {
                let fraction = min(max(panned, 0.0), 0.99)
                update(fraction)
            }
        case .ended, .cancelled:
            if interactionInProgress {
                interactionInProgress = false
                // TODO: - Support completion speed.
                shouldCompleteTransition = (panned > completeOnPercentage ||                panVelocity > InteractionConstants.velocityForComplete) &&
                    panVelocity > InteractionConstants.velocityForCancel
                shouldCompleteTransition ? finish() : cancel()
            }
            
        default : break
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension TransitionInteractiveController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
