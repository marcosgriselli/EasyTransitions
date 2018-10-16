//
//  AppDelegate.swift
//  EasyTransitions
//
//  Created by marcosgriselli on 04/07/2018.
//  Copyright (c) 2018 marcosgriselli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Modal
        window?.rootViewController = TodayCollectionViewController()
        
        // Navigation
//        let navigation = UINavigationController(rootViewController: GalleryTableViewController())
//        if #available(iOS 11.0, *) { navigation.navigationBar.prefersLargeTitles = true }
//        window?.rootViewController = navigation
        
        // Presentation
//        window?.rootViewController = BasePresentationViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

