//
//  Pan.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import Foundation
import UIKit

public enum Pan {
    case regular(PanDirection)
    #if os(iOS)
    case edge(UIRectEdge)
    #endif
}
