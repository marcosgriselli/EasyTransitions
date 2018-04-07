//
//  PanFactory.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import Foundation

internal class PanFactory {

    static func create(with pan: Pan) -> UIPanGestureRecognizer {
        var gestureRecognizer: UIPanGestureRecognizer
        switch pan {
        case .regular(_):
            gestureRecognizer = TransitionPanGestureRecognizer(pan: pan)
        case .edge(let rectEdge):
            let edgeGestureRecognizer = TransitionEdgePanGestureRecognier(pan: pan)
            edgeGestureRecognizer.edges = rectEdge
            gestureRecognizer = edgeGestureRecognizer
        }
        return gestureRecognizer
    }
}
