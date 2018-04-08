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
    
    public func animations(presenting: Bool,
                           modalView: UIView, in container: UIView) -> () -> Void {
        guard presenting else {
            return {
                self.blurView.effect = nil
                self.edgeLayoutConstraints?.match(to: self.initialFrame,
                                                  container: container)
                self.dismissAuxAnimation()
                container.layoutIfNeeded()
            }
        }
        
        return {
            self.blurView.effect = UIBlurEffect(style: .light)
            self.edgeLayoutConstraints?.constants(to: 0)
            self.presentAuxAnimation()
            container.layoutIfNeeded()
        }
    }
}
