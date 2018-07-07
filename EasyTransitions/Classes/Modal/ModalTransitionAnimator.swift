//
//  ModalTransitionAnimator.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import Foundation
import UIKit

public protocol ModalTransitionAnimator {
    var duration: TimeInterval { get }
    var auxAnimation: ((Bool) -> Void)? { get set }
    var onDismissed: (() -> Void)? { get set }
    var onPresented: (() -> Void)? { get set }
    func layout(presenting: Bool,
                modalView: UIView,
                in container: UIView)
    func animate(presenting: Bool,
                 modalView: UIView,
                 in container: UIView) 
}
