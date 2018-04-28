//
//  PanGesture.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

internal protocol PanGesture {
    var pan: Pan { get set }
    init(pan: Pan)
    func percentagePanned() -> CGFloat
    func velocityForPan() -> CGFloat
}

// TODO: - Find a simpler way.
extension PanGesture where Self: UIPanGestureRecognizer {
    func percentagePanned() -> CGFloat {
        guard let view = view else {
            return 0
        }
        
        let translation = self.translation(in: view)
        switch pan {
        case .regular(let direction):
            switch direction {
            case .fromTop:
                return translation.y / view.bounds.height
            case .fromLeft:
                return translation.x / view.bounds.width
            case .fromBottom:
                return -translation.y / view.bounds.height
            case .fromRight:
                return -translation.x / view.bounds.width
            }
            #if os(iOS)
        case .edge(let rectEdge):
            switch rectEdge {
            case .top:
                return translation.y / view.bounds.height
            case .left:
                return translation.x / view.bounds.width
            case .bottom:
                return -translation.y / view.bounds.height
            case .right:
                return -translation.x / view.bounds.width
            default:
                return 0
            }
            #endif
        }
    }
    
    func velocityForPan() -> CGFloat {
        guard let view = view else {
            return 0
        }
        
        let velocity = self.velocity(in: view)
        switch pan {
        case .regular(let direction):
            switch direction {
            case .fromTop:
                return velocity.y
            case .fromLeft:
                return velocity.x
            case .fromBottom:
                return -velocity.y
            case .fromRight:
                return -velocity.x
            }
            #if os(iOS)
        case .edge(let rectEdge):
            switch rectEdge {
            case .top:
                return velocity.y
            case .left:
                return velocity.x
            case .bottom:
                return -velocity.y
            case .right:
                return -velocity.x
            default:
                return 0
            }
            #endif
        }
    }
}
