//
//  CollectionViewController.swift
//  Transitions_Example
//
//  Created by Marcos Griselli on 04/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import EasyTransitions

public extension UICollectionView {    
    private func indexPathFor(cell: UICollectionViewCell) -> Int {
        return indexPath(for: cell)?.item ?? -1
    }

    var orderedVisibleCells: [UICollectionViewCell] {
        let items = visibleCells
        return items.sorted(by: { indexPathFor(cell: $1) > indexPathFor(cell: $0) })
    }
}

class CollectionViewController: UICollectionViewController {
    
    private let cellColor: UIColor
    private var interactor = TransitionInteractiveController()
    
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
        title = "Collection"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(UICollectionViewCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.addTarget(self, action: #selector(edgeSwipe(_:)))
    }
    
    @objc func edgeSwipe(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        
    }
    
    public func animations(presenting: Bool) -> [() -> Void] {
        return collectionView!.orderedVisibleCells.map { item in
            if presenting {
                item.transform = CGAffineTransform(translationX: 0, y: 40.0)
                item.alpha = 0.0
            } else {
                item.transform = CGAffineTransform.identity
                item.alpha = 1.0
            }
            return {
                if presenting {
                    item.transform = CGAffineTransform.identity
                    item.alpha = 1.0
                } else {
                    item.transform = CGAffineTransform(translationX: 0, y: 40.0)
                    item.alpha = 0.0
                }
            }
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
        let controller = CollectionViewController(itemSize: CGSize(width: 100, height: 140), cellColor: UIColor.blue)
        controller.title = "Blue CollectionView"
//        navigationController?.delegate = self
        interactor.wireTo(viewController: controller, with: .edge(.left))
        navigationController?.pushViewController(controller, animated: true)
    }
}

//extension CollectionViewController: UINavigationControllerDelegate {
//    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if operation == .push {
//            return nil
//        }
//        if interactor.interactionInProgress {
//            let swipeBackAnimator = SwipeBackTransitionAnimator()
//            if let collectionController = fromVC as? CollectionViewController {
//                swipeBackAnimator.toAnimations = animations(presenting: true)
//                swipeBackAnimator.fromAnimationsBlock = collectionController.animations(presenting: false)
//            }
//            return swipeBackAnimator
//        }
//        return nil
//    }
//    
//    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return interactor.interactionInProgress ? interactor : nil
//    }
//}

