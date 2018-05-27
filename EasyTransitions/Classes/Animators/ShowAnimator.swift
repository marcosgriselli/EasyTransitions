//
//  MatchAnimator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 08/04/2018.
//

import Foundation
import UIKit

open class ShowAnimator: NavigationTransitionAnimator {

    // MARK: - Init
    public init() {}

    // MARK: - NavigationTransitionAnimator
    public var auxAnimations: (Bool) -> [AuxAnimation] = { _ in [] }
    open var duration: TimeInterval {
        return 0.7
    }
    
    public func layout(presenting: Bool, fromView: UIView,
                       toView: UIView, in container: UIView) {
        if presenting  {
            toView.frame = toView.frame.offsetBy(dx: toView.frame.width,
                                                 dy: 0)
            container.addSubview(toView)
        } else {
            container.insertSubview(toView, belowSubview: fromView)
            let toFrame = toView.frame
            toView.frame = toFrame.offsetBy(dx: -toFrame.size.width * 0.3, dy: 0)
        }
    }
    
    public func animations(presenting: Bool, fromView: UIView,
                           toView: UIView, in container: UIView) {
        if presenting {
            let fromFrame = fromView.frame
            toView.frame = fromFrame
            fromView.frame.offsetBy(dx: -fromFrame.size.width * 0.3, dy: 0)
        } else {
            let fromFrame = fromView.frame
            fromView.frame = fromFrame.offsetBy(dx: fromFrame.size.width,
                                                dy: 0.0)
            toView.frame.origin = CGPoint(x: 0.0, y: 0.0)
        }
    }
}
