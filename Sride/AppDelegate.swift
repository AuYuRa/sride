//
//  AppDelegate.swift
//  Sride
//
//  Created by sulagna on 3/22/22.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {




    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // --- Copy this only
        
        let parseConfig = ParseClientConfiguration {
//            $0.applicationId = "FtRZyRZYNWMNapuCXQoaVWaqxWPm7Y1xMAp4N3xo" // autumn's
//            $0.clientKey = "xgwasRCAWEe3SXCPE8PbCZvGXu5KKB500cHAp55H" // autumn's
                $0.applicationId = "XWZjnQzTr4poMBDokYoTUcebjL9Gi3NFmm6jrpKy" // <- dora's
                $0.clientKey = "FRv8YsdiaKBDsd9f7DzIVVPnYEPStw0Lefsi7jL5" // <- dora's
                $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: parseConfig)
        
        // --- end copy


        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

