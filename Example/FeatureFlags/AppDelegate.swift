//
//  AppDelegate.swift
//  FeatureFlags
//
//  Created by Ross Butler on 10/18/2018.
//  Copyright (c) 2018 Ross Butler. All rights reserved.
//

import UIKit
import FeatureFlags

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //FeatureFlags.deleteAllFeaturesFromCache()
        let localUrl = Bundle.main.url(forResource: "Features", withExtension: "json")
        let remoteUrl = URL(string: "https://raw.githubusercontent.com/rwbutler/FeatureFlags/master/Example/FeatureFlags/Features.json")
        FeatureFlags.configurationURL = remoteUrl
        FeatureFlags.localFallbackConfigurationURL = localUrl
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = vc
        
        return true
    }
}

private extension AppDelegate {
    
    func printInformation() {
        FeatureFlags.printFeatureFlags()
        print("\n")
        FeatureFlags.printExtendedFeatureFlagInformation()
    }
}
