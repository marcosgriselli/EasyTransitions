//
//  AppDetailView.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 19/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class AppDetailView: UIView {
    
    let cardView = CardView()
    let scrollView = UIScrollView()
    private var cardViewWidthConstraint: NSLayoutConstraint!
    private var cardViewHeightConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        set(shadowStyle: .todayCard)
        backgroundColor = UIColor.clear
        scrollView.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        addSubview(scrollView)
        scrollView.edgesToSuperview()
        scrollView.addSubview(cardView)

        cardView.topToSuperview()
        cardViewWidthConstraint = cardView.width(335)
        cardViewHeightConstraint = cardView.height(
            to: cardView, cardView.widthAnchor, multiplier: 412/335
        )
        cardView.centerXToSuperview()
        
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor.white
        scrollView.addSubview(whiteView)
        whiteView.topToBottom(of: cardView)
        whiteView.left(to: self)
        whiteView.right(to: self)
        whiteView.edgesToSuperview(excluding: .top)
        whiteView.height(1000)
    }
    
    func layout(presenting: Bool) {
        let cardLayout: CardView.Layout = presenting ? .expanded : .collapsed
        cardViewWidthConstraint.constant = presenting ? 375 : 335
        let multiplier: CGFloat = presenting ? 492/375 : 412/335
        cardViewHeightConstraint = cardViewHeightConstraint
            .setMultiplier(multiplier: multiplier)
        cardView.set(layout: cardLayout)
        scrollView.layer.cornerRadius = cardLayout.cornerRadius
        layoutIfNeeded()
    }
}
