//
//  SceneDelegate.swift
//  WikiLinks - iOS
//
//  Created by Anton Styagun on 03.07.2020.
//  Copyright © 2020 Anton Styagun. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        handleUIOpenURLContexts(URLContexts)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        handleUIOpenURLContexts(connectionOptions.urlContexts)
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    fileprivate func handleUIOpenURLContexts(_ URLContexts: Set<UIOpenURLContext>) {
        for context in URLContexts {
            let decodedUrl = context.url.absoluteString.removingPercentEncoding!
            let filePath = removeSchemeFromUrl(decodedUrl)
            let absoluteUrl = absoluteWikiUrlFromRelativePath(filePath)
            
            UIApplication.shared.open(absoluteUrl)
        }
    }

    fileprivate func removeSchemeFromUrl(_ url: String) -> String {
        var result = url
        
        if result.hasPrefix("wiki:") {
            result = String(result.dropFirst(5))
            
            if result.hasPrefix("//") {
                result = String(result.dropFirst(2))
            }
        }
        
        return result
    }
    
    fileprivate func absoluteWikiUrlFromRelativePath(_ filePath: String) -> URL {
        var urlComponents = URLComponents(string: "nextcloud://open-file")!
        urlComponents.queryItems = [
            URLQueryItem(name: "path", value: filePath),
            URLQueryItem(name: "link", value: UserDefaults.standard.string(forKey: "nextcloudAddress")),
            URLQueryItem(name: "user", value: UserDefaults.standard.string(forKey: "nextcloudUsername"))
        ]
        return urlComponents.url!
    }
}
