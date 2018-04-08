//
//  AppDetailViewController.swift
//  AppStoreTransition
//
//  Created by Marcos Griselli on 18/03/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit

enum AnimationPosition {
    case present
    case dismiss
}

class AppDetailViewController: UIViewController {
    
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    
    // TODO: - Inject card detail.
    init() {
        super.init(nibName: String(describing: AppDetailViewController.self),
                   bundle: Bundle(for: AppDetailViewController.self))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.delegate = self
        let cardLayout = CardViewLayout.collapsed
        cardView.set(layout: cardLayout)
        contentView.layer.cornerRadius = cardLayout.cornerRadius
        backView.layer.cornerRadius = cardLayout.cornerRadius
        backView.set(shadowStyle: .todayCard)
        if #available(iOS 11, *) {
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    func animations(for position: AnimationPosition) -> () -> Void {
        return { [weak self] in
            let presenting: Bool = position == AnimationPosition.present
            let cardLayout: CardViewLayout = presenting ? .expanded : .collapsed
            self?.contentView.layer.cornerRadius = cardLayout.cornerRadius
            self?.backView.layer.cornerRadius = cardLayout.cornerRadius
            self?.cardView.set(layout: cardLayout)
        }
    }
}

extension AppDetailViewController: CardViewDelegate {
    func closeCardView() {
        dismiss(animated: true, completion: nil)
    }
}
