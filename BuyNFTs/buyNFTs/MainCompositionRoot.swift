//
//  MainCompositionRoot.swift
//  buyNFTs-DEV
//
//  Created by Gustavo Araujo Santos on 19/11/22.
//

import UIKit
import Shared
import Login
import Home
import Article

final class MainCompositionRoot {

    static let shared = MainCompositionRoot()

    private init() { }

    func buildMainCoordinator(_ navigationController: UINavigationController) -> MainCoordinatorProtocol {
        let coordinator = MainCoordinator(navigationController)
        return coordinator
    }

    func buildLoginCoordinator(_ navigationController: UINavigationController) -> LoginCoordinatorProtocol {
        let existsTokenInKeyChainUseCase = SharedCompositionRoot.shared.buildExistsTokenInKeyChainUseCase()
        let coordinator = LoginCoordinator(navigationController,
                                           existsTokenInKeyChainUseCase: existsTokenInKeyChainUseCase)
        return coordinator
    }

    func buildTabCoordinator(_ navigationController: UINavigationController) -> TabCoordinatorProtocol {
        let coordinator = TabCoordinator(navigationController)
        return coordinator
    }

    func buildHomeCoordinator(_ navigationController: UINavigationController) -> HomeCoordinatorProtocol {
        let coordinator = HomeCoordinator(navigationController)
        return coordinator
    }

    func buildArticleCoordinator(_ navigationController: UINavigationController) -> ArticleCoordinatorProtocol {
        let coordinator = ArticleCoordinator(navigationController)
        return coordinator
    }

}
