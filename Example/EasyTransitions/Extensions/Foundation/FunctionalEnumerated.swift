//
//  FunctionalEnumerated.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 08/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

public extension Array {

    func enumeratedMap<T>(_ transform: (Int, Element) -> T) -> [T] {
        var result: [T] = []
        result.reserveCapacity(count)
        for (index, element) in self.enumerated() {
            result.append(transform(index, element))
        }
        return result
    }
}
