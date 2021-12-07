//
//  AppDelegate.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let defaultConfiguration = "Default Configuration"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: defaultConfiguration, sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}
