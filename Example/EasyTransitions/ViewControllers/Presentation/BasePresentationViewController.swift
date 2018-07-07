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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 375, height: 812))
        imageView.image = UIImage(named: "home")
        view.addSubview(imageView)
        
        /// Swipe from the bottom to trigger transition.
        prepareInteractivePresentation()
    }
    
    func prepareInteractivePresentation() {
        let modalTransitionDelegate = ModalTransitionDelegate()
        let controller = PresentationViewController()
        let presentationController = P(presentedViewController: controller, presenting: self)
        modalTransitionDelegate.set(presentationController: presentationController)
        
        let presentAnimator = PresentationControllerAnimator(finalFrame: presentationController.frameOfPresentedViewInContainerView)
        presentAnimator.auxAnimation = { controller.animations(presenting: $0) }
        modalTransitionDelegate.set(animator: presentAnimator, for: .present)
        modalTransitionDelegate.set(animator: presentAnimator, for: .dismiss)
        
        modalTransitionDelegate.wire(
            viewController: self,
            with: .regular(.fromBottom),
            navigationAction: { self.present(controller, animated: true, completion: nil) }
        )
        
        presentAnimator.onDismissed = prepareInteractivePresentation
        presentAnimator.onPresented = {
            modalTransitionDelegate.wire(
                viewController: controller,
                with: .regular(.fromTop),
                navigationAction: {
                    controller.dismiss(animated: true, completion: nil)
            })
        }
        controller.transitioningDelegate = modalTransitionDelegate
        controller.modalPresentationStyle = .custom
    }
}
