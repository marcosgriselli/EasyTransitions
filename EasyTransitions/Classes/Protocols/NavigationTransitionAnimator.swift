//
//  Transition.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//


public protocol NavigationTransitionAnimator {
    var duration: TimeInterval { get }
    func layout(presenting: Bool, fromView: UIView, toView: UIView, in container: UIView)
    func performAnimation(duration: TimeInterval, presenting: Bool, fromView: UIView, toView: UIView, in container: UIView, then: @escaping () -> Void)
}
