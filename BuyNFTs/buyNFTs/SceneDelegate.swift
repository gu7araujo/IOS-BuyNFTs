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

        let navigationController: UINavigationController = .init()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()

        let mainCoordinator = MainCoordinator.init(navigationController)
        mainCoordinator.start()
    }
}
