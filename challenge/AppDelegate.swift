//
//  AppDelegate.swift
//  challenge
//
//  Created by Oscar on 11/9/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let startViewController = StartViewController()
        let startConfigurator = StartModuleConfigurator()
        startConfigurator.configureModuleForViewInput(viewInput: startViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = startViewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        return true
    }
}

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

