//
//  AppDelegate.swift
//  People at Total
//
//  Created by Florian Letellier on 31/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


   	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Fabric.with([Crashlytics.self])
        IQKeyboardManager.sharedManager().enable = true
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "accessToken") != nil {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Storyboard", bundle: nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarcontroller") as! UITabBarController
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if "peopleauthapp" == url.scheme || (url.scheme?.hasPrefix("com.googleusercontent.apps"))! {
            if let vc = window?.rootViewController as? ViewController {
                vc.oauth2?.handleRedirectURL(url)
                return true
            }
        }
        return false
    }


}

