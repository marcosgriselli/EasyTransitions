//
//  AppStoreAnimator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import Foundation
import UIKit

public class AppStoreAnimator: ModalTransitionAnimator {
    
    public var initialFrame: CGRect
    private var edgeLayoutConstraints: NSEdgeLayoutConstraints?
    private let blurView: UIVisualEffectView = UIVisualEffectView(effect: nil)

    public var blurEffectStyle: UIBlurEffectStyle = .light {
        didSet {
            if blurView.effect != nil && oldValue != blurEffectStyle {
                self.blurView.effect = UIBlurEffect(style: self.blurEffectStyle)
            }
        }
    }

    public var auxAnimation: ((Bool) -> Void)? = .none

    public var onReady: () -> Void = {}
    public var onDismissed: (() -> Void)? = .none
    public var onPresented: (() -> Void)? = .none

    public init(initialFrame: CGRect) {
        self.initialFrame = initialFrame
    }

    public init(initialFrame: CGRect, blurEffectStyle: UIBlurEffectStyle) {
        self.blurEffectStyle = blurEffectStyle
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
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = container.bounds
        container.addSubview(blurView)
        let blurConstraints = NSEdgeLayoutConstraints(view: blurView, container: container)
        blurConstraints.toggleConstraints(true)
        blurConstraints.constants(to: 0)

        
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
            self.blurView.effect = UIBlurEffect(style: self.blurEffectStyle)
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
