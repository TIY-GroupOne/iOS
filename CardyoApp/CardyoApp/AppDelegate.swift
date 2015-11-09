//
//  AppDelegate.swift
//  CardyoApp
//
//  Created by Mac Bellingrath on 11/8/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let token = NetworkManager.sharedManager().token
        
        var nc: UINavigationController?
        
        
        if token != nil {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let nav = sb.instantiateInitialViewController() as? UINavigationController {
                nc = nav
            }
        } else if token == nil {
                let usersb = UIStoryboard(name: "User", bundle: nil)
                if let nav = usersb.instantiateInitialViewController() as? UINavigationController {
                    nc = nav
                2
            }
        }
    
    
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        return true
    }



}

