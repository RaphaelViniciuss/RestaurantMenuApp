//
//  SceneDelegate.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 20/10/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        startAppCoordinator()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

    private func startAppCoordinator() {
        guard let window = window else {
            fatalError("Something is wrong by UIWindow")
        }

        appCoordinator = AppCoordinator(window: window)

        guard let appCoordinator = appCoordinator else {
            fatalError("Something is wrong by Coordination")
        }

        appCoordinator.start()
        window.makeKeyAndVisible()
    }
}
