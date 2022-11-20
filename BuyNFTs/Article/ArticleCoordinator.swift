//
//  ArticleCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 26/09/22.
//

import UIKit
import Shared

public protocol ArticleCoordinatorProtocol: CoordinatorProtocol { }

public class ArticleCoordinator: ArticleCoordinatorProtocol {

    // MARK: - Properties

    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [CoordinatorProtocol] = []
    public var type: CoordinatorType { .article }

    // MARK: - Initialization

    required public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("ArticleCoordinator deinit")
    }

    // MARK: - Methods

    public func start() {
        let articleVM = ArticleCompositionRoot.shared.buildArticleViewModel()
        let articleVC = ArticleCompositionRoot.shared.buildArticleViewController(articleVM)
        navigationController.pushViewController(articleVC, animated: false)
    }
}
