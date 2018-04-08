//
//  AppStoreAnimator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import Foundation

public class AppStoreAnimator: ModalTransitionAnimator {
    
    private var initialFrame: CGRect
    private var edgeLayoutConstraints: NSEdgeLayoutConstraints?
    private let blurView = UIVisualEffectView(effect: nil)
    
    public var presentAuxAnimation: () -> Void = {}
    public var dismissAuxAnimation: () -> Void = {}
    
    public var onReady: () -> Void = {}
    public var onDismissed: () -> Void = {}
    
    public init(initialFrame: CGRect) {
        self.initialFrame = initialFrame
    }
    
    public var duration: TimeInterval {
        return 0.9
    }
    
    public func layout(presenting: Bool, modalView: UIView, in container: UIView) {
        if presenting {
            blurView.frame = container.frame
            container.addSubview(blurView)
            
            modalView.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(modalView)
            edgeLayoutConstraints = NSEdgeLayoutConstraints(view: modalView,
                                                            container: container,
                                                            frame: initialFrame)
            edgeLayoutConstraints?.toggleConstraints(true)
            container.layoutIfNeeded()
            onReady()
        } else {
            edgeLayoutConstraints?.constants(to: 0)
        }
    }
    
    public func performAnimation(duration: TimeInterval, presenting: Bool, modalView: UIView, in container: UIView, then: @escaping () -> Void) -> UIViewImplicitlyAnimating? {
        
        let presentingLayout = {
            self.blurView.effect = UIBlurEffect(style: .light)
            self.edgeLayoutConstraints?.verticalConstants(to: 0)
            self.presentAuxAnimation()
            container.layoutIfNeeded()
        }
        
        let dimissLayout = {
            self.blurView.effect = nil
            self.edgeLayoutConstraints?.match(to: self.initialFrame,
                                              container: container)
            self.dismissAuxAnimation()
            container.layoutIfNeeded()
        }
        
        if #available(iOS 10.0, *) {
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.7)
            let animation = presenting ? presentingLayout : dimissLayout
            animator.addAnimations(animation)
            if presenting {
                animator.addAnimations({
                    self.edgeLayoutConstraints?.horizontalConstants(to: 0)
                    container.layoutIfNeeded()
                }, delayFactor: 0.16)
            }
            
            animator.addCompletion { position in
                then()
                if position != .end {
                    self.edgeLayoutConstraints?.horizontalConstants(to: 0)
                    presentingLayout()
                } else {
                    if !presenting {
                        self.onDismissed()
                    }
                }
            }
            
            animator.isUserInteractionEnabled = true
            return animator
        }
        
        return nil
    }
}
