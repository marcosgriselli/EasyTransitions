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
        let presentationController = FramePresentationController(
            presentedViewController: controller,
            presenting: self
        )
        modalTransitionDelegate.set(presentationController: presentationController)

        let presentAnimator = PresentAnimator(finalFrame: presentationController.frameOfPresentedViewInContainerView)
        
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        shadowView.frame = view.frame
        shadowView.alpha = 0
        view.addSubview(shadowView)
        
        // Aux for different animators? 
        presentAnimator.auxAnimation = (animationBlock: {
            let presenting = $0 == .present
            controller.animations(presenting: presenting)
            let shadowAlpha: CGFloat = presenting ? 1.0 : 0.0
            shadowView.alpha = shadowAlpha
        }, delayOffset: 0)
        
        presentAnimator.onFinish = {
            if $0 == .dismiss { shadowView.removeFromSuperview() }
        }
        
        modalTransitionDelegate.set(animator: presentAnimator, for: .present)
        modalTransitionDelegate.set(animator: presentAnimator, for: .dismiss)
        modalTransitionDelegate.wire(viewController: controller,
                                     with: .regular(.fromTop))
        
        controller.transitioningDelegate = modalTransitionDelegate
        controller.modalPresentationStyle = .custom
        
        present(controller, animated: true, completion: nil)
    }
}
