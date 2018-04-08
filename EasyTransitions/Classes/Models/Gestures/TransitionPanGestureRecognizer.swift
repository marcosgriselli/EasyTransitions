//
//  TransitionPanGestureRecognizer.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

internal class TransitionPanGestureRecognizer: UIPanGestureRecognizer, PanGesture {
    var pan: Pan
    required init(pan: Pan) {
        self.pan = pan
        super.init(target: nil, action: nil)
    }
}
