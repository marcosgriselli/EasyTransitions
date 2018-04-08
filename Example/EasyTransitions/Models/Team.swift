//
//  Team.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 08/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

public struct Team {
    var imageName: String
    var name: String
}

extension Team {

    static let all: [Team] = [
        Team(imageName: "", name: "Blue Team"),
        Team(imageName: "", name: "Red Team"),
        Team(imageName: "", name: "Green Team"),
        Team(imageName: "", name: "Purple Team"),
    ]
}
