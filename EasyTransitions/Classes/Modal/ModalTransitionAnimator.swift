//
//  ModalTransitionAnimator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import Foundation

public protocol ModalTransitionAnimator {
    var duration: TimeInterval { get }
    var onDismissed: () -> Void { get set }
    func layout(presenting: Bool,
                modalView: UIView,
                in container: UIView)
    func animations(presenting: Bool,
                    modalView: UIView,
                    in container: UIView) -> () -> Void 
}
