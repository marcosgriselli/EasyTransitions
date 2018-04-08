//
//  SlideTransitionAnimator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import Foundation

final public class SlideTransitionAnimator: NavigationTransitionAnimator {
    
    public init() {}
    
    public var duration: TimeInterval {
        return 0.35
    }

    public func layout(presenting: Bool, fromView: UIView, toView: UIView, in container: UIView) {
        if presenting {
            toView.frame = toView.frame.offsetBy(dx: container.frame.width,
                                                 dy: 0.0)
            container.addSubview(toView)
        } else {
            toView.frame = toView.frame.offsetBy(dx: -50.0,
                                                 dy: 0.0)
            container.insertSubview(toView, belowSubview: fromView)
        }
    }
    
    public func performAnimation(duration: TimeInterval, presenting: Bool, fromView: UIView, toView: UIView, in container: UIView, then: @escaping () -> Void) {
        UIView.animate(withDuration: duration, animations: {
            if presenting {
                fromView.frame.origin.x -= 50
                toView.frame = toView.frame.offsetBy(dx: -container.frame.width,
                                                         dy: 0.0)
            } else {
                toView.frame = toView.frame.offsetBy(dx: 50.0,
                                                     dy: 0.0)
                fromView.frame = fromView.frame.offsetBy(dx: container.frame.width,
                                                         dy: 0.0)
            }
        }) { _ in then() }
    }
}
