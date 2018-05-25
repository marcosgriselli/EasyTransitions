//
//  Transition.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

public protocol NavigationTransitionAnimator {
    var duration: TimeInterval { get }
    var auxAnimations: (Bool) -> [AuxAnimation] { get set }
    func layout(presenting: Bool, fromView: UIView,
                toView: UIView, in container: UIView)
    func animations(presenting: Bool,
                    fromView: UIView, toView: UIView,
                    in container: UIView)
}
