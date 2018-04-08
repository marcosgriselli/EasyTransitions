//
//  MatchAnimator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 08/04/2018.
//

import Foundation

public class MatchAnimator: NavigationTransitionAnimator {

    // MARK: - Properties
    private var initialFrame: CGRect
    private var edgeLayoutConstraints: NSEdgeLayoutConstraints?

    // MARK: - Init
    public init(initialFrame: CGRect) {
        self.initialFrame = initialFrame
    }

    // MARK: - NavigationTransitionAnimator
    public var auxAnimations: (Bool) -> [AuxAnimation] = { _ in [] }
    public var duration: TimeInterval {
        return 0.35
    }
    
    public func layout(presenting: Bool, fromView: UIView,
                       toView: UIView, in container: UIView) {
        container.insertSubview(toView, belowSubview: fromView)
        toView.frame = fromView.frame
    }
    
    public func animations(duration: TimeInterval, presenting: Bool, fromView: UIView, toView: UIView, in container: UIView) {
//        let fromFrame = fromView.frame
//        fromView.frame = fromFrame.offsetBy(dx: fromFrame.size.width,
//                                            dy: 0.0)
        fromView.frame = initialFrame
        toView.frame.origin = CGPoint(x: 0.0, y: 0.0)
//        fromView.frame = CGRect(x: 100, y: 150, width: 100, height: 100)
    }
}
