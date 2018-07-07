//
//  PresentationViewController.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 21/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class P: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 10,
                      y: presentingViewController.view.bounds.height - 380,
                      width: 355,
                      height: 370)
    }
}

class PresentationViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    // Layouts
    private typealias Layout = (transform: CGAffineTransform, alpha: CGFloat)
    private let startLayout: Layout = (.init(translationX: 0, y: 30), 0.0)
    private let endLayout: Layout = (.identity, 1.0)
    
    init() {
        super.init(nibName: String(describing: PresentationViewController.self),
                   bundle: Bundle(for: PresentationViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 16.0
        set(layout: startLayout)
    }

    public func animations(presenting: Bool) {
        let layout = presenting ? endLayout : startLayout
        set(layout: layout)
    }
    
    private func set(layout: Layout) {
        imageView.transform = layout.transform
        imageView.alpha = layout.alpha
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func connectTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
