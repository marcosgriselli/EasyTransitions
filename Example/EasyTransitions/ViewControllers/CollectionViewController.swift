//
//  CollectionViewController.swift
//  Transitions_Example
//
//  Created by Marcos Griselli on 04/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import EasyTransitions

private struct CellAnimate {
    var transform: CGAffineTransform
    var alpha: CGFloat

    private init(transform: CGAffineTransform, alpha: CGFloat) {
        self.transform = transform
        self.alpha = alpha
    }
    
    static let show = CellAnimate(transform: CGAffineTransform.identity, alpha: 1.0)
    static let hide = CellAnimate(transform: CGAffineTransform(translationX: 0, y: 50),
                                  alpha: 0.0)
}

class CollectionViewController: UICollectionViewController {
    
    private let cellColor: UIColor
    var navigationTransitionDelegate = NavigationTransitionDelegate()
    
    init(itemSize: CGSize, cellColor: UIColor) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.cellColor = cellColor
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(UICollectionViewCell.self)
    }

    public func animations(presenting: Bool) -> [AuxAnimation] {
        let animation: CellAnimate = presenting ? .show : .hide
        let setupAnimation: CellAnimate = !presenting ? .show : .hide
        return collectionView!.orderedVisibleCells.enumeratedMap { index, item in
            item.transform = setupAnimation.transform
            item.alpha = setupAnimation.alpha
            let offset = CGFloat(index) * 0.1
            return AuxAnimation(block: {
                item.transform = animation.transform
                item.alpha = animation.alpha
            }, delayOffset: offset)
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.backgroundColor = cellColor
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = CollectionViewController(itemSize: CGSize(width: 200, height: 140), cellColor: UIColor.blue)
        controller.title = "Blue CollectionView"
        
        let slideTransition = SlideTransitionAnimator()
        slideTransition.auxAnimations = { controller.animations(presenting: $0) }
        navigationTransitionDelegate.set(animator: slideTransition)
        navigationTransitionDelegate.wire(viewController: controller,
                                          with: .edge(.left))
        navigationController?.pushViewController(controller, animated: true)
    }
}


