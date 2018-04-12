//
//  GalleryItem.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 12/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

public struct GalleryItem {
    var title: String
    var imageName: String
    
    private init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    
    public static let all: [GalleryItem] = [
        GalleryItem(title: "Beach", imageName: "gallery_1"),
        GalleryItem(title: "Forest", imageName: "gallery_2"),
        GalleryItem(title: "Lake", imageName: "gallery_3"),
        GalleryItem(title: "Park", imageName: "gallery_4")
    ]
}
