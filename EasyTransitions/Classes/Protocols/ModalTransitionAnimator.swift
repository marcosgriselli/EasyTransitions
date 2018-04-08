//
//  ModalTransitionAnimator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import Foundation

public protocol ModalTransitionAnimator {
    var duration: TimeInterval { get }
    func layout(presenting: Bool,
                modalView: UIView,
                in container: UIView)
    func performAnimation(duration: TimeInterval,
                          presenting: Bool,
                          modalView: UIView,
                          in container: UIView,
                          then: @escaping () -> Void) -> UIViewImplicitlyAnimating?
}
