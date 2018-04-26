//
//  NSEdgeLayoutConstraints.swift
//  EasyTransitions
//
//  Created by Marcos Griselli on 07/04/2018.
//

import UIKit

public final class NSEdgeLayoutConstraints {
    
    // MARK: - Properties
    public var top, left, bottom, right: NSLayoutConstraint
    private var constraints: [NSLayoutConstraint] {
        return [top, left, bottom, right]
    }
    
    // MARK: - Init
    public convenience init(view: UIView, container: UIView) {
        self.init(view: view, container: container, frame: .zero)
    }

    public init(view: UIView, container: UIView, frame: CGRect) {
        top = view.topAnchor.constraint(equalTo: container.topAnchor, constant: frame.minY)
        left = view.leftAnchor.constraint(equalTo: container.leftAnchor, constant: frame.minX)
        bottom = view.bottomAnchor.constraint(equalTo: container.bottomAnchor,
                                              constant: frame.maxY - container.frame.height)
        right = view.rightAnchor.constraint(equalTo: container.rightAnchor,
                                            constant: frame.maxX - container.frame.width)
    }
    
    public func constants(to value: CGFloat) {
        constraints.forEach { $0.constant = value }
    }
    
    public func verticalConstants(to value: CGFloat) {
        top.constant = value
        bottom.constant = value
    }
    
    public func horizontalConstants(to value: CGFloat) {
        left.constant = value
        right.constant = value
    }
    
    public func match(to frame: CGRect, container: UIView) {
        top.constant = frame.minY
        left.constant = frame.minX
        bottom.constant = frame.maxY - container.frame.height
        right.constant = frame.maxX - container.frame.width
    }
    
    public func toggleConstraints(_ value: Bool) {
        constraints.forEach { $0.isActive = value }
    }
}
