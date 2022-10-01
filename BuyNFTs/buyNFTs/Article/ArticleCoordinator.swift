//
//  ArticleCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 26/09/22.
//

import UIKit

protocol ArticleCoordinatorProtocol: Coordinator { }

class ArticleCoordinator: ArticleCoordinatorProtocol {

    // MARK: - Properties

    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .article }

    // MARK: - Initialization

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("ArticleCoordinator deinit")
    }

    // MARK: - Methods

    func start() {
        let articleVC: ArticleViewController = .init()
        navigationController.pushViewController(articleVC, animated: true)
    }
}
