//
//  AppDetailViewController.swift
//  AppStoreTransition
//
//  Created by Marcos Griselli on 18/03/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit
import EasyTransitions

class AppDetailViewController: UIViewController {
    
    private let detailView = AppDetailView()

    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.cardView.onClose = {
            self.dismiss(animated: true, completion: nil)
        }
        layout(presenting: false)
    }
    
    func layout(presenting: Bool) {
        detailView.layout(presenting: presenting)
    }
    
    func isReadyToDismiss() -> Bool {
        if #available(iOS 11.0, *) {
            return detailView.scrollView.contentOffset.y == 0
        } else {
            return false
        }
    }
}
