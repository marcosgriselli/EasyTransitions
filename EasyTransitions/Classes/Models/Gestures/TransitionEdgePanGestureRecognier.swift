//
//  TransitionEdgePanGestureRecognier.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

#if os(iOS)
internal class TransitionEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer, PanGesture {
    var pan: Pan
    required init(pan: Pan) {
        self.pan = pan
        super.init(target: nil, action: nil)
    }
}
#endif
