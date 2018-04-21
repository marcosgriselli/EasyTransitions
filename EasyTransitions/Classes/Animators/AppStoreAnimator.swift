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
    
    public var auxAnimation: ((Bool) -> Void)? = .none
    
    public var onReady: () -> Void = {}
    public var onDismissed: (() -> Void)? = .none
    
    public init(initialFrame: CGRect) {
        self.initialFrame = initialFrame
    }
    
    public var duration: TimeInterval {
        return 0.85
    }
    
    public func layout(presenting: Bool, modalView: UIView, in container: UIView) {
        guard presenting else {
            edgeLayoutConstraints?.constants(to: 0)
            return
        }
        
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
    }
    
    public func animate(presenting: Bool,
                        modalView: UIView, in container: UIView) {
        if presenting {
            self.blurView.effect = UIBlurEffect(style: .light)
            self.edgeLayoutConstraints?.constants(to: 0)
            // self.edgeLayoutConstraints?.vertical(to: 0) with 0.16 offsetDelay
        } else {
            blurView.effect = nil
            edgeLayoutConstraints?.match(to: self.initialFrame,
                                              container: container)
        }
        auxAnimation?(presenting)
        modalView.layoutIfNeeded()
        container.layoutIfNeeded()
    }
}
