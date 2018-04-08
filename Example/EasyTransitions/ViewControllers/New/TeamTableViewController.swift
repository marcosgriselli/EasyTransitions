//
//  TeamTableViewController.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 08/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import EasyTransitions

class TeamTableViewController: UITableViewController {
    
    private let teams = Team.all
    private var navigationDelegate = NavigationTransitionDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Teams"
        setup(tableView: tableView)
        navigationController?.delegate = navigationDelegate
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    private func setup(tableView: UITableView) {
        tableView.register(TeamTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 95.0
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TeamTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(team: teams[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIViewController()
        controller.title = "New"
        controller.view.backgroundColor = UIColor.red
        
        let cell = tableView.cellForRow(at: indexPath)!
        let cellFrame = navigationController!.view.convert(cell.frame, from: tableView)
        let matchAnimator = MatchAnimator(initialFrame: cellFrame)
        navigationDelegate.set(animator: matchAnimator)
        navigationDelegate.wire(viewController: controller, with: .regular(.horizontal))
        navigationController?.pushViewController(controller, animated: true)
    }
}
