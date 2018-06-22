//
//  CGRect + KeyPaths.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 22/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

extension CGRect {
    static var verticalKeyPaths: [WritableKeyPath<CGRect, CGFloat>] {
        return [\.size.height, \.origin.y]
    }
    
    static var horizontalKeyPaths: [WritableKeyPath<CGRect, CGFloat>] {
        return [\.size.width, \.origin.x]
    }
}

extension UIView {

    // TODO: - Create something more generic?
    func match(_ keyPaths: [WritableKeyPath<CGRect, CGFloat>], to rect: CGRect) {
        keyPaths.forEach {
            self.frame[keyPath: $0] = rect[keyPath: $0]
        }
    }
}
