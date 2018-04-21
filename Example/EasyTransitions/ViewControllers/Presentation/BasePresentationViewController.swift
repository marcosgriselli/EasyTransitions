//
//  BasePresentationViewController.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 21/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import EasyTransitions

class BasePresentationViewController: UIViewController {
    
    let modalTransitionDelegate = ModalTransitionDelegate()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 375, height: 812))
        imageView.image = UIImage(named: "home")
        view.addSubview(imageView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.run()
        }
    }
    
    @objc func run() {
        let controller = PresentationViewController()
        let presentationController = P(presentedViewController: controller, presenting: self)
        modalTransitionDelegate.set(presentationController: presentationController)

        let presentAnimator = PresentationControllerAnimator(finalFrame: presentationController.frameOfPresentedViewInContainerView)
        presentAnimator.auxAnimation = { controller.animations(presenting: $0) }
        modalTransitionDelegate.set(animator: presentAnimator, for: .present)
        modalTransitionDelegate.set(animator: presentAnimator, for: .dismiss)
        modalTransitionDelegate.wire(viewController: controller,
                                     with: .regular(.fromTop))
        
        controller.transitioningDelegate = modalTransitionDelegate
        controller.modalPresentationStyle = .custom
        
        present(controller, animated: true, completion: nil)
    }
}
