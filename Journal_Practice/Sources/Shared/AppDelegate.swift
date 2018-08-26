//
//  AppDelegate.swift
//  Journal_Practice
//
//  Created by 이의현 on 2018. 8. 25..
//  Copyright © 2018년 이의현. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        customizeNavigationBar()
        
        if
            let navigationController = window?.rootViewController as? UINavigationController,
            let timelineViewController = navigationController.topViewController as?
                TimelineViewController {
            timelineViewController.environment = Environment()
        }
        
        return true
    }
    
    private func customizeNavigationBar() {
        if let navigationController = window?.rootViewController as? UINavigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.barStyle = .black
            // navigationController.navigationBar.barTintColor = .black
            // navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 0.141, green: 0.541, blue: 0.933, alpha: 1.0)]
            navigationController.navigationBar.tintColor = .black
            // UIColor(red: 0.141, green: 0.541, blue: 0.933, alpha: 1.0) // 버튼 글자 색
            
            let bgImage = UIImage.gradientImage(with: [.gradientStart, .gradientEnd], size: CGSize(width: UIScreen.main.bounds.width, height: 1))
            navigationController.navigationBar.barTintColor = UIColor(patternImage: bgImage!)
        }
        
    }

}

