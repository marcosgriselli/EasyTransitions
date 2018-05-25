//
//  PanFactory.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import Foundation
import UIKit

internal class PanFactory {

    static func create(with pan: Pan) -> UIPanGestureRecognizer {
        var gestureRecognizer: UIPanGestureRecognizer
        switch pan {
        case .regular(_):
            gestureRecognizer = TransitionPanGestureRecognizer(pan: pan)
            #if os(iOS)
        case .edge(let rectEdge):
            let edgeGestureRecognizer = TransitionEdgePanGestureRecognizer(pan: pan)
            edgeGestureRecognizer.edges = rectEdge
            gestureRecognizer = edgeGestureRecognizer
            #endif
        }
        return gestureRecognizer
    }
}
