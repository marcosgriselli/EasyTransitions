//
//  UIViewControllerContextTransitioning + ET.swift
//  Pods
//
//  Created by Marcos Griselli on 07/06/2018.
//

import UIKit

extension UIViewControllerContextTransitioning {

    var isPresenting: Bool {
        let fromViewController = viewController(forKey: .from)!
        let toViewController = viewController(forKey: .to)!
        return toViewController.presentingViewController === fromViewController
    }
    
    var modalView: UIView {
        let key: UITransitionContextViewKey = isPresenting ? .to : .from
        return view(forKey: key)!
    }
}
