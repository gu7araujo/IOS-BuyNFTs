//
//  SceneDelegate.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 01/09/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var coordinator: MainCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let safeWindow = UIWindow(windowScene: windowScene)
        safeWindow.frame = UIScreen.main.bounds

        let navViewController = UINavigationController()
        coordinator = MainCoordinator.init(navViewController)
        coordinator?.start()
        safeWindow.rootViewController = navViewController
        safeWindow.makeKeyAndVisible()
        window = safeWindow

        AppStartUp.start()
    }
}
