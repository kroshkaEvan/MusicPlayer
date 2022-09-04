//
//  SceneDelegate.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 2.09.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let musicVC = ModuleBuilder.createMusicModule()
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: musicVC)
        window?.makeKeyAndVisible()
    }
}
