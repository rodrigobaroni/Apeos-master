//
//  AppDelegate.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 20/03/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        
        let navigator = MarvelNavigator(navigationController: navigationController)
        navigator.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }

}
