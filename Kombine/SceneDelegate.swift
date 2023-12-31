//
//  SceneDelegate.swift
//  Kombine
//
//  Created by Gabriel Puppi on 10/09/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
 
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let vc = TagListViewController()
        window.rootViewController = vc
        self.window = window
        window.makeKeyAndVisible()
    }
}

