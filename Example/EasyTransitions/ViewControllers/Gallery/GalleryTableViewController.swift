//
//  GalleryTableViewController.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 12/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import EasyTransitions

class GalleryTableViewController: UITableViewController {
    
    private let navigationDelegate = NavigationTransitionDelegate()
    private let items = GalleryItem.all

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gallery"
        setup(tableView: tableView)
        navigationController?.delegate = navigationDelegate
    }
    
    private func setup(tableView: UITableView) {
        tableView.register(GalleryTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 180.0
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GalleryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(item: items[indexPath.row])
        return cell
    }
    
    // MARK: - UITableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = CollectionViewController()
        let showAnimator = ShowAnimator()
        showAnimator.auxAnimations = {
            return [self.animations(presenting: $0), viewController.animations(presenting: $0)].flatMap { $0 }
        }
        navigationDelegate.set(animator: showAnimator, forOperation: .push)
        navigationDelegate.set(animator: showAnimator, forOperation: .pop)
        navigationDelegate.wire(viewController: viewController,
                                with: .regular(.fromLeft))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func animations(presenting: Bool) -> [AuxAnimation] {
        return tableView.visibleCells.enumeratedMap { index, cell in
            let galleryCell = cell as! GalleryTableViewCell
            galleryCell.set(layout: presenting ? .standard : .converted)
            let delayFactor = Double(index) * 0.2
            return ({ galleryCell.set(layout: presenting ? .converted : .standard) },
                    delayFactor)
        }
    }
}
