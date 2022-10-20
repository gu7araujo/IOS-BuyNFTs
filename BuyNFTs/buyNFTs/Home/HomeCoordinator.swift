//
//  HomeCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import UIKit
import Domain

protocol HomeCoordinatorProtocol: Coordinator {
    func showProductDetails(_ product: Product)
}

class HomeCoordinator: HomeCoordinatorProtocol {

    // MARK: - Properties

    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .home }

    // MARK: - Initialization

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("HomeCoordinator deinit")
    }

    // MARK: - Methods

    func start() {
        let homeVM = HomeViewModel()
        let homeVC = HomeViewController(homeVM)
        homeVC.didSendEventsClosure = { event in
            switch event {
            case CryptosCell.Event.openCryptoDetails(let product): self.showProductDetails(product)
            default: break
            }
        }
        navigationController.pushViewController(homeVC, animated: true)
    }

    func showProductDetails(_ product: Product) {
        let productDetailsVC = ProductDetailsViewController(product: product)
        navigationController.present(productDetailsVC, animated: true)
    }
}
