//
//  TodayCollectionViewController.swift
//  AppStoreTransition
//
//  Created by Marcos Griselli on 18/03/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit
import EasyTransitions

class TodayCollectionViewController: UICollectionViewController {
    
    private var appStoreAnimator: AppStoreAnimator!
    private var interactiveController = TransitionInteractiveController()
    
    // MARK: - Init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 335, height: 412)
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(TodayCollectionViewCell.self)
    }

    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TodayCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let detailViewController = AppDetailViewController()
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            present(detailViewController, animated: true, completion: nil)
            return
        }

        let cellFrame = view.convert(cell.frame, from: collectionView)
        
        appStoreAnimator = AppStoreAnimator(initialFrame: cellFrame)
//        appStoreTransition.onReady = { cell.isHidden = true }
//        appStoreTransition.onComplete = { cell.isHidden = false }
        appStoreAnimator.presentAuxAnimation = detailViewController.animations(for: .present)
        appStoreAnimator.dismissAuxAnimation = detailViewController.animations(for: .dismiss)
    
        interactiveController.wireTo(viewController: detailViewController,
                           with: Pan.regular(.vertical))
        interactiveController.navigationAction = {
            detailViewController.dismiss(animated: true, completion: nil)
        }
        
        detailViewController.transitioningDelegate = self
        detailViewController.modalPresentationStyle = .custom
        present(detailViewController, animated: true, completion: nil)
    }
}

extension TodayCollectionViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalTransitionConfigurator(transitionAnimator: appStoreAnimator)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalTransitionConfigurator(transitionAnimator: appStoreAnimator)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveController.interactionInProgress ? interactiveController : nil
    }
}
