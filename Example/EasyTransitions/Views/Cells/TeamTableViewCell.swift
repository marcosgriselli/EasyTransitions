//
//  TeamTableViewCell.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 08/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    func configure(team: Team) {
        teamImageView.image = UIImage(named: team.imageName)
        teamNameLabel.text = team.name
    }
}
