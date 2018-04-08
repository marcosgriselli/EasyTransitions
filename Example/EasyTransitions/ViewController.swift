//
//  ViewController.swift
//  EasyTransitions
//
//  Created by marcosgriselli on 04/07/2018.
//  Copyright (c) 2018 marcosgriselli. All rights reserved.
//

import UIKit
import EasyTransitions

class ViewController: UIViewController {
    
    private let interactiveController = TransitionInteractiveController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.delegate = self
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        let new = UIViewController()
        new.title = "New"
        new.view.backgroundColor = UIColor.blue
        interactiveController.wireTo(viewController: new, with: .regular(.vertical))
        interactiveController.navigationAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(new, animated: true)
    }
}

extension ViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return nil
        }
        if interactiveController.interactionInProgress {
            let slideTransition = SlideTransitionAnimator()
            return NavigationTransitionConfigurator(transitionAnimator: slideTransition)
        }
        return nil
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveController.interactionInProgress ? interactiveController : nil
    }
}
