//
//  SlideTransitionAnimator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import Foundation

public class SlideTransitionAnimator: NavigationTransitionAnimator {
    
    public init() {}
    
    public var auxAnimations: (Bool) -> [AuxAnimation] = { _ in [] }
    
    public var duration: TimeInterval {
        return 0.35
    }
    
    public func layout(presenting: Bool, fromView: UIView,
                       toView: UIView, in container: UIView) {
        if presenting {
            toView.frame = toView.frame.offsetBy(dx: container.frame.width,
                                                 dy: 0.0)
            container.addSubview(toView)
        } else {
            container.insertSubview(toView, belowSubview: fromView)
        }
    }
    
    public func animations(duration: TimeInterval, presenting: Bool, fromView: UIView, toView: UIView, in container: UIView) {
        if presenting {
            fromView.frame.origin.x -= 50
            toView.frame = container.frame
        } else {
            fromView.bounds.origin.x -= fromView.bounds.size.width
        }
    }
}
